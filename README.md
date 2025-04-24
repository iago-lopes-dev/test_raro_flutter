# Flutter Payments App

Este é um projeto Flutter modular estruturado com **Clean Architecture**, criado para gerenciamento
de pagamentos com foco em separação de responsabilidades, manutenibilidade e escalabilidade.

---

## Arquitetura

O projeto segue os princípios da **Clean Architecture**, dividindo responsabilidades em camadas bem
definidas:

- **Domain**: Define as entidades e contratos do negócio.
- **Data**: Implementa repositórios, models e datasources.
- **Infra**: Fornece implementações concretas para integração com APIs ou dados mockados.
- **Presentation**: Contém os Blocs, páginas, widgets e elementos visuais.
- **Core**: Armazena elementos compartilhados e reutilizáveis, como temas, constantes, extensões e
  helpers.

---

## Estrutura de Pastas

```
lib/
└── src/
    ├── core/
    │   ├── base/
    │   │   ├── constants/           # Constantes globais
    │   │   ├── enums/               # Enums como PaymentTabEnum
    │   │   ├── errors/              # Definições de erros genéricos
    │   │   ├── interfaces/          # Interfaces genéricas (use cases, falhas, etc)
    │   ├── theme/                   # Criado para centralizar cores e estilos de texto
    │   ├── utils/                   # Funções auxiliares e extensões (como formatações de valores e datas)
    │   └── core.dart                # Exportações unificadas do core
    ├── modules/
    │   └── payments/
    │       ├── data/                # Models e implementações de datasources/repositories
    │       ├── domain/              # Entidades e contratos do negócio
    │       ├── infra/               # Integrações com JSON mock ou APIs reais
    │       └── presentation/        # UI: Blocs, páginas, widgets e modais
    ├── app_widget.dart             # Widget principal da aplicação
    └── main.dart                   # Ponto de entrada do app
test/                               # Testes unitários
```

---

## Primeiros Passos

1. **Clone o projeto:**
   ```bash
   git clone https://github.com/iago-lopes-dev/test_raro_flutter
   cd test_raro_flutter

2. **Instale as dependências:**
   ```bash
   flutter pub get

3. **Execute o aplicativo:**
   ```bash
   flutter run

4. **Rode os testes unitários:**
   ```bash
   flutter test

## Tecnologias Utilizadas

- Flutter
- Dart
- Bloc Pattern para gerenciamento de estado
- Clean Architecture
- Material Design 3 (com tema customizado)

## Funcionalidades Desenvolvidas

- Interface modular com tabs e filtros
- Cards personalizados e listas dinâmicas para agendamentos, transações e resumos
  Modal inferior customizado
- Página principal com separação de responsabilidade via bloc
- Estilo visual padronizado com tema centralizado
  layout fiel ao protótipo fornecido
  no [Figma](https://www.figma.com/design/QWC5IksyTx2k65ZzkPz3r1/Processo-seletivo---Dev-flutter?node-id=1-4313&t=WNNCW8T4MMI6Z9M8-1).

## Fallback Inteligente

- Foi implementado um fallback automático no payments_info_model.dart, garantindo
  compatibilidade com diferentes formatos de resposta da API.
- Quando a API retorna transactionHeaders em vez de transactionFilters, o sistema interpreta
  corretamente os dados, garantindo que a interface funcione sem erros e que o usuário tenha uma
  experiência fluida mesmo com diferentes versões do backend.

## Observações Técnicas

- A estrutura de temas, estilos de texto e cores foi criada do zero.
- Fallbacks foram adicionados em models críticos para prevenir quebras caso a API mude.
- PopScope.onPopInvoked está sendo usado com // ignore: deprecated_member_use temporariamente, até
  que onPopInvokedWithResult esteja disponível em versão estável do Flutter.
- Essa decisão foi tomada de forma consciente para preservar o comportamento da navegação com
  retorno de dados personalizados (selectedFilters), sem comprometer a funcionalidade.