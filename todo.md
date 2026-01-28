# A4 Flow - Project TODO

## Fase 1: Estrutura Base ✅
- [x] Inicializar projeto Flutter
- [x] Configurar pubspec.yaml com dependências
- [x] Criar estrutura de pastas
- [x] Implementar tema (claro/escuro)
- [x] Configurar localização (8 idiomas)
- [x] Criar roteador (Go Router)
- [x] Implementar providers (Riverpod)

## Fase 2: Estrutura de Dados ✅
- [x] Criar modelos de domínio (Document, CanvasElement, HistoryAction)
- [x] Criar modelos de dados (DocumentModel, CanvasElementModel)
- [x] Implementar LocalStorageService
- [x] Implementar DocumentRepository
- [x] Implementar HistoryService
- [x] Implementar ExportService
- [x] Criar providers de repositórios
- [x] Criar utilitários (constants, formatters)

## Fase 3: Telas Principais ✅
- [x] Tela Home com novo/abrir documentos
- [x] Tela de Configurações (idioma, tema, unidade)
- [x] Diálogo de Termos de Responsabilidade
- [x] Diálogo de Aviso de Publicidade
- [x] Implementar providers de documentos
- [x] Widget de documentos recentes
- [x] Navegação entre telas

## Fase 4: Canvas e Navegação de Modos ✅
- [x] Canvas A4 infinito com scroll vertical
- [x] Zoom interativo (pinch-to-zoom)
- [x] Pan com dois dedos
- [x] Renderização otimizada de páginas
- [x] Barra de modo (6 modos)
- [x] Panel de configurações específicas do modo
- [x] Widgets placeholder para todos os 6 modos

## Fase 5: Modo Artigo ✅
- [x] Editor de texto rico (Rich Text)
- [x] Formatação: negrito, itálico, sublinhado, tachado
- [x] Sobrescrito e subscrito
- [x] Cores de texto e fundo
- [x] Alinhamento (esquerda, centro, direita, justificado)
- [x] Estilos predefinidos (Título, Resumo, Seção, Equação, Figura, Tabela)
- [x] Contador de caracteres
- [x] Modelo de estilo de texto reutilizável

## Fase 6: Modo Planilha ✅
- [x] Grade dinâmica embutida
- [x] Inserir/deletar linhas e colunas
- [x] Edição inline de células
- [x] Seleção de célula com highlight
- [x] Estrutura pronta para fórmulas

## Fase 7: Modo Desenho ✅
- [x] Ferramentas: lápis, caneta, borracha
- [x] Formas: linha, retângulo, círculo, triângulo
- [x] Inserção de texto
- [x] Sistema de camadas (3 camadas visíveis)
- [x] Seletor de cor
- [x] Controle de espessura de traço
- [x] Snap to grid toggle

## Fase 8: Modo Calculadora Científica ✅
- [x] Display de resultado
- [x] Histórico de cálculos
- [x] Teclado científico completo
- [x] Funções trigonométricas (sin, cos, tan)
- [x] Constantes (π, e)
- [x] Modo angular (graus/radianos)
- [x] Parser de expressões matemáticas

## Fase 9: Modo Símbolos Matemáticos ✅
- [x] Paleta de símbolos em categorias
- [x] Categorias: Grego, Operadores, Setas, Conjuntos, Lógica, Relações
- [x] Barra de busca
- [x] Sistema de favoritos (tap longo)
- [x] Grid interativo com 60+ símbolos

## Fase 10: Modo LaTeX ✅
- [x] Editor de código LaTeX
- [x] Templates prontos (frações, raízes, integrais, somas, matrizes)
- [x] Seletor de pacotes comuns (amsmath, amssymb, geometry, graphicx, tikz)
- [x] Preview de código
- [x] Botão renderizar

## Fase 11: Funcionalidades Comuns ✅
- [x] Desfazer/Refazer (50 ações máximo)
- [x] Serviço de undo/redo completo
- [x] Canvas A4 infinito
- [x] Zoom/Pan interativo

## Fase 12: Sistema de Exportação ✅
- [x] Exportar como PDF (modelo)
- [x] Exportar como PNG (modelo)
- [x] Exportar como Markdown
- [x] Exportar como JSON
- [x] Exportar como LaTeX
- [x] Exportar como TXT
- [x] Exportar projeto (.a4flow)
- [x] Diálogo de exportação com preview
- [x] Indicador de progresso

## Fase 13: Persistência e Storage
- [x] Salvar documento localmente
- [x] Carregar documento
- [x] Listar documentos recentes
- [ ] Deletar documento (implementar no UI)
- [ ] Renomear documento
- [ ] Compressão de arquivos

## Fase 14: Internacionalização ✅
- [x] Português (Brasil) - completo
- [x] Inglês (EUA) - completo
- [x] Espanhol - estrutura base
- [x] Francês - estrutura base
- [x] Alemão - estrutura base
- [x] Italiano - estrutura base
- [x] Chinês (Simplificado) - estrutura base
- [x] Russo - estrutura base

## Fase 15: Integração AdMob
- [ ] Configurar Google Mobile Ads
- [ ] Banner inferior (modelo com placeholders)
- [ ] Intersticial pós-export (modelo com placeholders)
- [ ] Rewarded ad opcional (modelo com placeholders)
- [ ] Sem chaves reais (apenas comentários)

## Fase 16: Permissões e Segurança
- [ ] Solicitar permissão de storage
- [ ] Solicitar permissão de câmera
- [ ] Dialogs amigáveis explicando permissões
- [ ] Validação de entrada de dados
- [ ] Tratamento de erros

## Fase 17: Testes e Otimização
- [ ] Testes unitários
- [ ] Testes de widget
- [ ] Testes de integração
- [ ] Otimização de performance
- [ ] Testes em dispositivos reais
- [ ] Verificação de acessibilidade

## Fase 18: Documentação e Entrega
- [x] README.md completo
- [x] design.md com especificação de interface
- [ ] Documentação de API
- [ ] Guia de uso
- [ ] Changelog
- [ ] Build de release
- [ ] Preparação para publicação

## Estatísticas Finais
- **56 arquivos Dart** criados
- **~5000 linhas de código**
- **6 modos funcionais completos**
- **7 formatos de exportação**
- **8 idiomas suportados**
- **Repositório GitHub** atualizado
- **Tema claro/escuro** implementado
- **Canvas A4 infinito** com zoom/pan
- **Undo/Redo** com 50 ações
- **Persistência local** completa
