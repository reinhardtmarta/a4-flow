# A4 Flow - Project TODO

## Fase 1: Estrutura Base
- [x] Inicializar projeto Flutter
- [x] Configurar pubspec.yaml com dependências
- [x] Criar estrutura de pastas
- [x] Implementar tema (claro/escuro)
- [x] Configurar localização (8 idiomas)
- [x] Criar roteador (Go Router)
- [x] Implementar providers (Riverpod)

## Fase 2: Estrutura de Dados
- [x] Criar modelos de domínio (Document, CanvasElement, HistoryAction)
- [x] Criar modelos de dados (DocumentModel, CanvasElementModel)
- [x] Implementar LocalStorageService
- [x] Implementar DocumentRepository
- [x] Implementar HistoryService
- [x] Implementar ExportService
- [x] Criar providers de repositórios
- [x] Criar utilitários (constants, formatters)

## Fase 3: Telas Principais
- [x] Tela Home com novo/abrir documentos
- [x] Tela de Configurações (idioma, tema, unidade)
- [x] Diálogo de Termos de Responsabilidade
- [x] Diálogo de Aviso de Publicidade
- [x] Implementar providers de documentos
- [x] Widget de documentos recentes
- [x] Navegação entre telas

## Fase 4: Canvas e Navegação de Modos
- [x] Canvas A4 infinito com scroll vertical
- [x] Zoom interativo (pinch-to-zoom)
- [x] Pan com dois dedos
- [x] Renderização otimizada de páginas
- [x] Barra de modo (6 modos)
- [x] Panel de configurações específicas do modo
- [x] Widgets placeholder para todos os 6 modos

## Fase 5: Modo Artigo
- [ ] Editor de texto rico (Rich Text)
- [ ] Formatação: negrito, itálico, sublinhado, tachado
- [ ] Sobrescrito e subscrito
- [ ] Cores de texto e fundo
- [ ] Alinhamento (esquerda, centro, direita, justificado)
- [ ] Estilos predefinidos (Título, Resumo, Seção, Equação, Figura, Tabela)
- [ ] Listas numeradas e com marcadores
- [ ] Cabeçalho/rodapé com numeração automática
- [ ] Seletor de colunas (1, 2, 3)
- [ ] Configurações: margens, espaçamento, fonte

## Fase 6: Modo Planilha
- [ ] Grade infinita embutida
- [ ] Inserir/deletar linhas e colunas
- [ ] Formatação de célula (cores, negrito, alinhamento)
- [ ] Suporte a fórmulas científicas (SUM, AVG, etc.)
- [ ] Inserção de gráficos (barras, linhas, pizza, dispersão)
- [ ] Congelar cabeçalho
- [ ] Temas de cores para grade

## Fase 7: Modo Desenho
- [ ] Ferramentas: lápis, caneta, borracha
- [ ] Formas: linha, retângulo, círculo, triângulo, polígono
- [ ] Inserção de texto
- [ ] Sistema de camadas (5-10)
- [ ] Transformações: redimensionar, rotacionar, mover
- [ ] Snap to grid
- [ ] Configurações: espessura, cores, opacidade

## Fase 8: Modo Calculadora Científica
- [ ] Display de resultado
- [ ] Histórico de cálculos
- [ ] Teclado científico completo
- [ ] Funções trigonométricas (sin, cos, tan)
- [ ] Logaritmos (log, ln)
- [ ] Constantes (π, e)
- [ ] Matrizes e operações matriciais
- [ ] Funções estatísticas
- [ ] Conversão de unidades
- [ ] Solver
- [ ] Modo angular (graus/radianos)
- [ ] Inserir resultado (texto, imagem, LaTeX)

## Fase 9: Modo Símbolos Matemáticos
- [ ] Paleta de símbolos em categorias
- [ ] Categorias: Grego, Operadores, Setas, Conjuntos, Lógica, Relações
- [ ] Barra de busca
- [ ] Inserir como texto ou gráfico
- [ ] Sistema de favoritos
- [ ] Configurações: tamanho, cor

## Fase 10: Modo LaTeX
- [ ] Editor de código LaTeX
- [ ] Syntax highlighting
- [ ] Autocompletar básico
- [ ] Preview renderizado em tempo real
- [ ] Suporte a pacotes comuns (amsmath, amssymb, geometry, graphicx, tikz)
- [ ] Botão renderizar
- [ ] Inserir no canvas

## Fase 11: Funcionalidades Comuns
- [ ] Desfazer/Refazer (≥50 ações)
- [ ] Copiar/Colar/Duplicar objetos
- [ ] Agrupar/Desagrupar
- [ ] Trazer para frente/Enviar para trás
- [ ] Alinhar/Distribuir
- [ ] Redimensionar objetos
- [ ] Mover objetos
- [ ] Rotacionar objetos
- [ ] Inserir imagens
- [ ] Inserir documentos (PDF, DOCX, TXT)
- [ ] Inserir tabelas
- [ ] Inserir gráficos
- [ ] Inserir formas

## Fase 12: Sistema de Exportação
- [ ] Exportar como PDF
- [ ] Exportar como PNG/JPG
- [ ] Exportar como Markdown/TXT
- [ ] Exportar projeto (.a4flow)
- [ ] Importar projeto (.a4flow)
- [ ] Configurações de exportação (resolução, qualidade)

## Fase 13: Conversor LaTeX Global
- [ ] Ícone conversor no topo
- [ ] Converter equações (texto/desenho/calculadora) para LaTeX
- [ ] Converter gráficos simples para TikZ
- [ ] Inserir no canvas
- [ ] Inserir no modo LaTeX

## Fase 14: Persistência e Storage
- [x] Salvar documento localmente
- [x] Carregar documento
- [x] Listar documentos recentes
- [ ] Deletar documento (implementar no UI)
- [ ] Renomear documento
- [ ] Compressão de arquivos

## Fase 15: Internacionalização
- [x] Português (Brasil) - completo
- [x] Inglês (EUA) - completo
- [x] Espanhol - estrutura base
- [x] Francês - estrutura base
- [x] Alemão - estrutura base
- [x] Italiano - estrutura base
- [x] Chinês (Simplificado) - estrutura base
- [x] Russo - estrutura base
- [ ] Formatação de números por locale
- [ ] Formatação de datas por locale

## Fase 16: Integração AdMob
- [ ] Configurar Google Mobile Ads
- [ ] Banner inferior (modelo com placeholders)
- [ ] Intersticial pós-export (modelo com placeholders)
- [ ] Rewarded ad opcional (modelo com placeholders)
- [ ] Sem chaves reais (apenas comentários)

## Fase 17: Permissões e Segurança
- [ ] Solicitar permissão de storage
- [ ] Solicitar permissão de câmera
- [ ] Dialogs amigáveis explicando permissões
- [ ] Validação de entrada de dados
- [ ] Tratamento de erros

## Fase 18: Testes e Otimização
- [ ] Testes unitários
- [ ] Testes de widget
- [ ] Testes de integração
- [ ] Otimização de performance
- [ ] Testes em dispositivos reais
- [ ] Verificação de acessibilidade

## Fase 19: Documentação e Entrega
- [x] README.md completo
- [x] design.md com especificação de interface
- [ ] Documentação de API
- [ ] Guia de uso
- [ ] Changelog
- [ ] Build de release
- [ ] Preparação para publicação
