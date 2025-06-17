import 'package:flutter_ai_toolkit/flutter_ai_toolkit.dart';

final List<ChatMessage> sampleMessages = [
  ChatMessage(
    id: '1',
    origin: MessageOrigin.user,
    text: 'Ciao come ti chiami?',
    attachments: const [],
  ),
  ChatMessage(
    id: '2',
    origin: MessageOrigin.llm,
    text: 'Sono il tuo assistente virtuale.',
    attachments: const [],
  ),
  ChatMessage(
    id: '3',
    origin: MessageOrigin.user,
    text: 'Cosa sai fare?',
    attachments: const [],
  ),
  ChatMessage(
    id: '4',
    origin: MessageOrigin.user,
    text:
        'Rispondi in markdown\n## Esempio di titolo'
        '\n- Esempio di lista\n- Con due elementi'
        '\n\nE un link: [Visita il sito Flutter](https://flutter.dev)',
    attachments: const [],
  ),
  ChatMessage(
    id: '5',
    origin: MessageOrigin.llm,
    text:
        "Ecco alcune cose che posso fare come assistente virtuale:\n\n"
        "## Funzioni principali:\n"
        "- Rispondere alle tue domande su vari argomenti.\n"
        "- Fornire informazioni aggiornate e consigli utili.\n"
        "- Aiutarti a gestire appuntamenti e promemoria.\n"
        "- Offrire suggerimenti per la produttività.\n"
        "- Tradurre testi in altre lingue.\n"
        "- Raccontare barzellette o curiosità.\n"
        "- Supportarti nell'organizzazione delle attività quotidiane.\n"
        "- Fornirti link utili, ad esempio [Visita il sito Flutter](https://flutter.dev).\n"
        "\nCome posso aiutarti oggi?",
    attachments: const [],
  ),
];
