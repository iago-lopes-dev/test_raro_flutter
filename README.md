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
    │   │   ├── constants/               # Constantes globais do projeto
    │   │   │   ├── app_constants.dart
    │   │   │   └── constants.dart
    │   │   ├── enums/                   # Enums usados em todo o projeto
    │   │   │   └── payment_tab_enum.dart
    │   │   ├── errors/                  # Definições de erros e exceções
    │   │   │   ├── errors.dart
    │   │   │   └── infra_error.dart
    │   │   ├── interfaces/              # Abstrações (usecases, repositórios, falhas)
    │   │   │   ├── failures.dart
    │   │   │   ├── usecase_interface.dart
    │   │   │   └── interfaces.dart
    │   │   └── base.dart
    │   ├── theme/                       # Estilos globais da aplicação
    │   │   ├── app_colors.dart
    │   │   └── app_text_styles.dart
    │   ├── utils/                       # Helpers, formatadores e extensões
    │   │   ├── converter_helper.dart
    │   │   ├── extensions.dart
    │   │   └── utils.dart
    │   └── core.dart                    # Exportações unificadas do core
    ├── modules/
    │   └── payments/
    │       ├── data/                               # Models e implementações de datasources/repositories
    │       │   ├── datasource/
    │       │   │   ├── payments_datasource.dart
    │       │   ├── model/
    │       │   │   ├── payments_info_model.dart
    │       │   │   ├── payments_scheduled_model.dart
    │       │   │   ├── payments_summary_model.dart
    │       │   │   ├── payments_transactions_model.dart
    │       │   │   ├── payments_transactions_header_model.dart
    │       │   │   └── model.dart
    │       │   ├── repository/
    │       │   │   ├── payment_repository_impl.dart
    │       │   │   └── repository.dart
    │       │   └── data.dart
    │       ├── domain/                              # Entidades e contratos do negócio
    │       │   ├── entity/
    │       │   │   ├── payments_info_entity.dart
    │       │   │   ├── payments_schedule_entity.dart
    │       │   │   ├── payments_summary_entity.dart
    │       │   │   ├── payments_transactions_entity.dart
    │       │   │   ├── payments_transactions_filter_entity.dart
    │       │   │   └── entity.dart
    │       │   ├── repository/
    │       │   │   ├── payment_repository.dart
    │       │   │   └── repository.dart
    │       │   ├── usecase/
    │       │   │   ├── get_payments_use_case.dart
    │       │   │   └── usecase.dart
    │       │   └── domain.dart
    │       ├── infra/                               # Integrações com JSON mock ou APIs reais
    │       │   ├── datasource/
    │       │   │   ├── payments_datasource_impl.dart
    │       │   ├── mock/
    │       │   │   └── payments_json.dart
    │       │   └── infra.dart
    │       ├── presentation/                        # UI: Blocs, páginas, widgets e modais
    │       │   ├── bloc/
    │       │   │   ├── payments_bloc.dart
    │       │   │   ├── payments_event.dart
    │       │   │   ├── payments_state.dart
    │       │   │   └── payments_tab_changed_event.dart
    │       │   ├── page/
    │       │   │   └── payments_page.dart
    │       │   ├── widgets/
    │       │   │   ├── custom_app_bar.dart
    │       │   │   ├── custom_shimmer_box.dart
    │       │   │   ├── custom_tab_selector.dart
    │       │   │   ├── buttons/
    │       │   │   │   └── custom_tab_button.dart
    │       │   │   ├── cards/
    │       │   │   │   ├── custom_schedule_card.dart
    │       │   │   │   ├── custom_summary_card.dart
    │       │   │   │   └── custom_transaction_card.dart
    │       │   │   ├── lists/
    │       │   │   │   ├── scheduled_list.dart
    │       │   │   │   ├── summaries_list.dart
    │       │   │   │   └── transactions_list.dart
    │       │   │   └── modals/
    │       │   │       └── custom_bottom_sheet_modal.dart
    ├── app_widget.dart                  # Widget principal da aplicação
    └── main.dart                        # Ponto de entrada do app
test/                            # Testes unitários
├── payments_bloc_test.dart
└── widget_test.dart
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

## Compatibilidade

- Este aplicativo foi desenvolvido e testado exclusivamente em dispositivos Android.
- A compatibilidade com iOS não foi validada. Algumas funcionalidades ou comportamentos visuais
  podem não funcionar como esperado em dispositivos Apple.
- Caso deseje rodar o app no iOS, recomenda-se revisar permissões, pacotes nativos e testes de
  layout específicos.