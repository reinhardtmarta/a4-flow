# A4 Flow - Advanced Local Editor for Academic Documents

A4 Flow é um editor avançado, local e multiplataforma para artigos científicos, teses e documentos acadêmicos. Desenvolvido em Flutter, oferece um canvas A4 infinito com múltiplos modos de edição especializados.

## Características Principais

**Canvas A4 Infinito**: Todas as páginas empilhadas verticalmente com scroll contínuo, sem limite de páginas.

**Múltiplos Modos de Edição**: Artigo, Planilha, Desenho, Calculadora Científica, Símbolos Matemáticos e LaTeX, todos editando diretamente no canvas.

**Editor de Artigo**: Texto rico com formatação completa, estilos predefinidos, cabeçalho/rodapé automático e suporte a múltiplas colunas.

**Planilha Integrada**: Grade infinita com fórmulas científicas, gráficos e formatação avançada.

**Ferramentas de Desenho**: Lápis, caneta, formas geométricas, camadas e transformações.

**Calculadora Científica**: Funções trigonométricas, logaritmos, matrizes, estatística, constantes e conversão de unidades.

**Paleta de Símbolos**: Letras gregas, operadores, setas, conjuntos e símbolos lógicos com busca.

**Editor LaTeX**: Código com syntax highlighting, preview renderizado e suporte a pacotes comuns.

**Funcionalidades Comuns**: Desfazer/refazer (≥50 ações), zoom/pan, inserir objetos, editar (redimensionar, mover, rotacionar, copiar/colar), camadas, agrupamento.

**Conversor LaTeX Global**: Converte equações e gráficos para código LaTeX/TikZ.

**Exportação**: PDF, PNG/JPG, Markdown/TXT, projeto (.a4flow).

**100% Local**: Sem nuvem, sem login, sem coleta de dados. Todos os arquivos salvos localmente.

**8 Idiomas**: Português (Brasil), Inglês, Espanhol, Francês, Alemão, Italiano, Chinês (Simplificado), Russo.

**Tema Claro/Escuro**: Suporte completo com transição suave.

**AdMob**: Modelo de anúncios (sem chaves reais, apenas placeholders comentados).

## Estrutura do Projeto

```
a4-flow/
├── lib/
│   ├── main.dart                 # Ponto de entrada
│   ├── app/
│   │   ├── config/               # Configuração da app
│   │   ├── routes/               # Roteamento (Go Router)
│   │   ├── theme/                # Temas (claro/escuro)
│   │   ├── localization/         # Internacionalização (8 idiomas)
│   │   └── providers/            # Providers Riverpod globais
│   ├── features/
│   │   ├── home/                 # Tela inicial
│   │   ├── editor/               # Editor principal
│   │   │   ├── screens/
│   │   │   ├── widgets/
│   │   │   ├── models/
│   │   │   ├── services/
│   │   │   └── modes/            # 6 modos de edição
│   │   ├── settings/             # Configurações
│   │   └── common/               # Widgets/utilitários comuns
│   ├── data/                     # Modelos de dados, repositórios
│   └── domain/                   # Entidades, casos de uso
├── assets/
│   ├── images/                   # Logo, ícones
│   ├── fonts/                    # Roboto, RobotoMono
│   └── data/                     # Dados estáticos (símbolos, etc.)
├── test/                         # Testes
├── pubspec.yaml                  # Dependências
├── design.md                     # Especificação de design
├── todo.md                       # Tarefas do projeto
└── README.md                     # Este arquivo
```

## Dependências Principais

- **flutter_riverpod**: Gerenciamento de estado
- **go_router**: Navegação
- **intl**: Internacionalização
- **flutter_math_fork**: Renderização de equações
- **pdf**: Exportação PDF
- **image**: Processamento de imagens
- **perfect_freehand**: Desenho livre
- **google_mobile_ads**: Integração AdMob
- **file_picker**: Seleção de arquivos
- **shared_preferences**: Armazenamento local

## Instalação e Execução

### Pré-requisitos

- Flutter SDK 3.0+
- Dart 3.0+
- Android Studio ou Xcode (para emulador)

### Passos

1. Clone o repositório:
```bash
git clone <repository-url>
cd a4-flow
```

2. Instale as dependências:
```bash
flutter pub get
```

3. Execute o app:
```bash
flutter run
```

4. Para build de release:
```bash
flutter build apk    # Android
flutter build ios    # iOS
```

## Arquitetura

O projeto segue a arquitetura Clean Architecture com as seguintes camadas:

**Presentation**: Telas, widgets, gerenciamento de estado com Riverpod
**Domain**: Entidades, casos de uso, interfaces de repositório
**Data**: Implementação de repositórios, modelos, fontes de dados

## Padrões de Código

- **State Management**: Riverpod com providers
- **Navigation**: Go Router com named routes
- **Localization**: Delegado customizado com suporte a 8 idiomas
- **Theming**: Material 3 com temas claro/escuro
- **Storage**: SharedPreferences para dados simples, arquivos locais para documentos

## Permissões

O app solicita as seguintes permissões:

- **Storage**: Leitura e escrita de arquivos (obrigatória)
- **Camera**: Captura de imagens (opcional)

Dialogs amigáveis explicam cada permissão antes de solicitar.

## Termos de Responsabilidade

Na primeira execução, o usuário deve aceitar os termos que confirmam:

- Todos os dados são armazenados localmente
- Sem sincronização em nuvem
- Sem coleta de dados
- App gratuito com suporte a anúncios

## Aviso de Publicidade

Após aceitar os termos, o usuário vê um aviso sobre a presença de anúncios (AdMob).

## Internacionalização

O app suporta 8 idiomas com seleção na tela de configurações:

- Português (Brasil)
- Inglês (Estados Unidos)
- Espanhol
- Francês
- Alemão
- Italiano
- Chinês (Simplificado)
- Russo

Strings centralizadas em `lib/app/localization/`.

## Performance

- Canvas otimizado com CustomPaint
- Lazy loading de páginas (renderizar apenas visíveis)
- Limite de histórico (50 ações) para economizar memória
- Compressão de imagens antes de inserção
- Suporte a documentos longos

## Testes

Execute testes com:

```bash
flutter test
```

## Contribuindo

Contribuições são bem-vindas! Por favor:

1. Faça fork do projeto
2. Crie uma branch para sua feature (`git checkout -b feature/AmazingFeature`)
3. Commit suas mudanças (`git commit -m 'Add some AmazingFeature'`)
4. Push para a branch (`git push origin feature/AmazingFeature`)
5. Abra um Pull Request

## Licença

Este projeto está licenciado sob a MIT License - veja o arquivo LICENSE para detalhes.

## Suporte

Para reportar bugs ou sugerir features, abra uma issue no repositório.

## Roadmap

- [ ] Sincronização em nuvem (opcional, futuro)
- [ ] Colaboração em tempo real
- [ ] Integração com Zotero/Mendeley
- [ ] Suporte a mais formatos de importação
- [ ] Plugins customizados
- [ ] Versão web

## Autores

Desenvolvido com ❤️ para a comunidade acadêmica.

## Agradecimentos

- Flutter team
- Comunidade Flutter
- Inspiração em editores acadêmicos como Overleaf e Microsoft Word
