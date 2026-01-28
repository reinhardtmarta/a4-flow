import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../app/config/app_config.dart';
import '../../../app/providers/app_providers.dart';
import '../../../features/common/utils/constants.dart';

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
  int _pageCount = 10; // Start with 10 pages, add more on demand

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _transformationController = TransformationController();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    // Load more pages when scrolling near the end
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 500) {
      setState(() {
        _pageCount += 5;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _transformationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final zoom = ref.watch(canvasZoomProvider);

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
                for (int i = 0; i < _pageCount; i++)
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
          // Page content area with margins
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header area
                Container(
                  padding: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Theme.of(context).colorScheme.outline,
                        width: 0.5,
                      ),
                    ),
                  ),
                  child: Text(
                    'Page $pageNumber',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.outline,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                // Content area (placeholder for editor content)
                Expanded(
                  child: Container(
                    color: Colors.transparent,
                    // Content will be rendered here by the editor mode
                  ),
                ),
              ],
            ),
          ),

          // Page number footer
          Positioned(
            bottom: 10,
            right: 15,
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
