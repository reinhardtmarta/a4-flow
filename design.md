# A4 Flow - Design de Interface Móvel

## Visão Geral

O A4 Flow é um editor avançado e local para documentos acadêmicos com foco em uma experiência de usuário intuitiva em dispositivos móveis. A interface foi projetada para orientação retrato (9:16) com suporte a uso com uma mão.

## Princípios de Design

- **Local First**: Todos os dados são armazenados localmente no dispositivo
- **Minimalista**: Interface limpa e descluttered
- **Acessibilidade**: Conformidade com WCAG 2.1 AA
- **Performance**: Responsivo mesmo com documentos longos
- **Consistência**: Alinhamento com iOS Human Interface Guidelines

## Estrutura de Telas

### 1. Tela Inicial (Home)

**Conteúdo Principal:**
- Cabeçalho com logo e ícone de configurações
- Cartão "Criar Novo Documento" com dois botões:
  - "Novo Documento" (ação primária)
  - "Abrir do Arquivo" (ação secundária)
- Seção "Documentos Recentes" com lista de projetos salvos
- Cada documento mostra: nome, data de modificação, ícone de menu

**Funcionalidade:**
- Toque em documento recente abre o editor
- Menu de contexto (⋯) permite deletar ou compartilhar
- Botão de configurações leva à tela de settings

### 2. Tela de Configurações

**Abas/Seções:**
1. **Geral**
   - Seletor de idioma (8 opções)
   - Toggle tema claro/escuro
   - Seletor de unidade (mm, cm, pt)

2. **Sobre**
   - Nome e versão do app
   - Descrição: "Editor local para documentos acadêmicos"
   - Links para Termos e Política de Privacidade

**Modais:**
- Diálogo de Termos (obrigatório na 1ª vez)
- Aviso de publicidade (AdMob)

### 3. Tela do Editor (Principal)

**Layout Vertical:**

```
┌─────────────────────────────────┐
│ A4 Flow    [↶] [↷] [⋯]          │  ← AppBar
├─────────────────────────────────┤
│                                 │
│  ┌─────────────────────────┐    │
│  │                         │    │
│  │   Canvas A4 Infinito    │    │
│  │   (Página 1)            │    │
│  │                         │    │
│  └─────────────────────────┘    │
│                                 │
│  ┌─────────────────────────┐    │
│  │   Canvas A4 Infinito    │    │
│  │   (Página 2)            │    │
│  │                         │    │
│  └─────────────────────────┘    │
│                                 │
│  ... (scroll infinito)          │
│                                 │
├─────────────────────────────────┤
│ [📄] [📊] [🖌️] [🧮] [ƒ] [⟨⟩]   │  ← Mode Toolbar
└─────────────────────────────────┘
```

**Componentes:**

#### AppBar
- Título: "A4 Flow"
- Ações:
  - Undo (↶)
  - Redo (↷)
  - Menu (⋯) com opções: Salvar, Exportar, Propriedades

#### Canvas Principal
- Fundo branco/cinza claro (tema claro) ou escuro (tema escuro)
- Páginas A4 empilhadas verticalmente
- Scroll infinito para adicionar páginas dinamicamente
- Zoom interativo (pinch-to-zoom)
- Pan com dois dedos ou arrastar com um

#### Mode Toolbar (Inferior)
- 6 botões em linha horizontal (scrollável)
- Cada modo tem ícone + label
- Modo ativo destacado com cor primária
- Modos: Artigo, Planilha, Desenho, Calculadora, Símbolos, LaTeX

### 4. Modo Artigo

**Toolbar Específico (topo, abaixo da AppBar):**
- Seletor de estilo (Título, Resumo, Seção, Equação, Figura, Tabela)
- Formatação: **B** (negrito), *I* (itálico), U (sublinhado)
- Cores: [Cor Texto] [Cor Fundo]
- Alinhamento: ← → ⟷

**Engrenagem de Configurações:**
- Margens (esquerda, direita, superior, inferior)
- Espaçamento entre linhas
- Fonte (Roboto, RobotoMono)
- Tamanho da fonte
- Número de colunas (1, 2, 3)

**Funcionalidade:**
- Editor de texto rico com suporte a:
  - Negrito, itálico, sublinhado, tachado
  - Sobrescrito e subscrito
  - Cores personalizadas
  - Listas numeradas/com marcadores
  - Cabeçalho/rodapé com numeração automática

### 5. Modo Planilha

**Toolbar Específico:**
- Inserir linha/coluna
- Deletar linha/coluna
- Inserir fórmula científica
- Inserir gráfico
- Formatação de célula

**Engrenagem de Configurações:**
- Número de linhas iniciais
- Número de colunas iniciais
- Tema de cores (padrão, azul, verde)
- Congelar cabeçalho

**Funcionalidade:**
- Grade infinita embutida
- Suporte a fórmulas (=SUM(), =AVG(), etc.)
- Inserção de gráficos (barras, linhas, pizza, dispersão)
- Formatação: cores, negrito, alinhamento

### 6. Modo Desenho

**Toolbar Específico:**
- Ferramentas: Lápis, Caneta, Borracha
- Formas: Linha, Retângulo, Círculo, Triângulo, Polígono
- Texto
- Camadas (5-10)

**Engrenagem de Configurações:**
- Espessura do traço (1-20px)
- Cor do traço
- Cor de preenchimento
- Opacidade (0-100%)
- Alinhar à grade (on/off)
- Tamanho da grade (5-50px)

**Funcionalidade:**
- Desenho livre com suporte a pressão
- Formas geométricas
- Camadas para organização
- Transformações: redimensionar, rotacionar, mover

### 7. Modo Calculadora Científica

**Layout:**
- Display grande (resultado)
- Histórico (scroll vertical)
- Teclado científico em grid

**Teclado:**
- Números (0-9)
- Operações básicas (+, -, ×, ÷)
- Funções trigonométricas (sin, cos, tan)
- Logaritmos (log, ln)
- Constantes (π, e)
- Matrizes
- Estatística
- Unidades
- Solver

**Engrenagem de Configurações:**
- Precisão (2-15 casas decimais)
- Modo angular (Graus/Radianos)

**Funcionalidade:**
- Histórico de cálculos
- Inserir resultado como:
  - Texto
  - Imagem
  - LaTeX

### 8. Modo Símbolos Matemáticos

**Layout:**
- Barra de busca (topo)
- Paleta de símbolos em grid
- Categorias: Grego, Operadores, Setas, Conjuntos, Lógica, Relações

**Engrenagem de Configurações:**
- Tamanho do símbolo
- Cor do símbolo
- Favoritos (marcar/desmarcar)

**Funcionalidade:**
- Busca por nome ou Unicode
- Inserir como texto ou gráfico
- Favoritos para acesso rápido

### 9. Modo LaTeX

**Layout:**
- Editor de código (esquerda/topo em mobile)
- Preview renderizado (direita/inferior em mobile)
- Botão "Renderizar"

**Engrenagem de Configurações:**
- Fonte da visualização
- Pacotes comuns (amsmath, amssymb, geometry, graphicx, tikz)

**Funcionalidade:**
- Syntax highlighting
- Autocompletar básico
- Preview em tempo real
- Inserir no canvas

## Paleta de Cores

### Tema Claro
- Primária: #2196F3 (Azul)
- Secundária: #03DAC6 (Teal)
- Fundo: #FAFAFA (Cinza muito claro)
- Superfície: #FFFFFF (Branco)
- Erro: #B00020 (Vermelho)

### Tema Escuro
- Primária: #BB86FC (Roxo)
- Secundária: #03DAC6 (Teal)
- Fundo: #121212 (Preto)
- Superfície: #1E1E1E (Cinza escuro)
- Erro: #CF6679 (Rosa)

## Tipografia

- **Fonte Principal**: Roboto
- **Fonte Mono**: RobotoMono (código, LaTeX)
- **Tamanhos**:
  - Display Large: 32sp
  - Headline: 20-24sp
  - Title: 14-16sp
  - Body: 12-16sp
  - Label: 10-14sp

## Funcionalidades Comuns

### Ações de Objeto
- Redimensionar (arrastar cantos)
- Mover (arrastar centro)
- Rotacionar (dois dedos)
- Copiar/Colar (menu de contexto)
- Duplicar (menu de contexto)
- Agrupar/Desagrupar
- Trazer para frente/Enviar para trás
- Alinhar/Distribuir

### Histórico
- Desfazer/Refazer (≥50 ações)
- Ícones na AppBar

### Zoom e Pan
- Pinch-to-zoom (0.25x a 4x)
- Dois dedos para pan
- Botões de zoom na toolbar

### Exportação
- PDF
- PNG/JPG
- Markdown/TXT
- Projeto (.a4flow)

## Fluxos de Usuário Principais

### 1. Criar Novo Documento
Home → [Novo Documento] → Editor (Modo Artigo padrão)

### 2. Editar Documento
Home → [Documento Recente] → Editor → Selecionar Modo → Editar

### 3. Exportar Documento
Editor → [⋯] → Exportar → Selecionar Formato → Salvar

### 4. Mudar Idioma
Home → [⚙️] → Geral → Idioma → Selecionar → Aplicar

## Considerações de Acessibilidade

- Contraste mínimo WCAG AA (4.5:1 para texto)
- Tamanho mínimo de toque: 44x44pt
- Labels para todos os ícones
- Suporte a leitura de tela (TalkBack/VoiceOver)
- Navegação por teclado

## Performance

- Canvas renderizado com CustomPaint para eficiência
- Lazy loading de páginas (renderizar apenas visíveis)
- Compressão de imagens antes de inserção
- Limite de histórico (50 ações)
- Otimização de memória para documentos longos

## Internacionalização

- 8 idiomas suportados
- Strings centralizadas em arquivos de localização
- Formatação de números/datas por locale
- RTL support (futuro)

## Permissões

- **Storage**: Leitura/escrita de arquivos (obrigatória)
- **Câmera**: Captura de imagens (opcional)
- Dialogs amigáveis explicando cada permissão
