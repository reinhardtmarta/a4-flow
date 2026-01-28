import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../app/config/app_config.dart';
import '../../../app/providers/app_providers.dart';

class CanvasWidget extends ConsumerStatefulWidget {
  final String documentId;

  const CanvasWidget({
    Key? key,
    required this.documentId,
  }) : super(key: key);

  @override
  ConsumerState<CanvasWidget> createState() => _CanvasWidgetState();
}

class _CanvasWidgetState extends ConsumerState<CanvasWidget> {
  late ScrollController _scrollController;
  late TransformationController _transformationController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _transformationController = TransformationController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _transformationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final zoom = ref.watch(canvasZoomProvider);
    final panOffset = ref.watch(canvasPanProvider);

    // Calculate A4 dimensions in pixels
    final a4WidthPx = AppConfig.a4Width * AppConfig.mmToPixels;
    final a4HeightPx = AppConfig.a4Height * AppConfig.mmToPixels;

    return GestureDetector(
      onScaleUpdate: (details) {
        // Handle pinch zoom
        final newZoom = (zoom * details.scale).clamp(
          AppConfig.minZoom,
          AppConfig.maxZoom,
        );
        ref.read(canvasZoomProvider.notifier).state = newZoom;
      },
      child: InteractiveViewer(
        transformationController: _transformationController,
        minScale: AppConfig.minZoom,
        maxScale: AppConfig.maxZoom,
        boundaryMargin: const EdgeInsets.all(100),
        child: SingleChildScrollView(
          controller: _scrollController,
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Infinite vertical stack of A4 pages
                for (int i = 0; i < 10; i++)
                  _buildA4Page(
                    context,
                    pageNumber: i + 1,
                    width: a4WidthPx,
                    height: a4HeightPx,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildA4Page(
    BuildContext context, {
    required int pageNumber,
    required double width,
    required double height,
  }) {
    return Container(
      width: width,
      height: height,
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border.all(
          color: Theme.of(context).colorScheme.outline,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Page content area (placeholder)
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Page $pageNumber',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.outline,
                  ),
                ),
              ],
            ),
          ),

          // Page number footer
          Positioned(
            bottom: 10,
            right: 10,
            child: Text(
              '$pageNumber',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: Theme.of(context).colorScheme.outline,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
