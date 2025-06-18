import 'package:ai_llm_chat/flutter_ai_toolkit.dart';

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
    id: '10',
    origin: MessageOrigin.user,
    text: 'Qual è la capitale della Francia?',
    attachments: const [],
  ),
  ChatMessage(
    id: '11',
    origin: MessageOrigin.llm,
    text: 'La capitale della Francia è Parigi.',
    attachments: const [],
  ),
  ChatMessage(
    id: '12',
    origin: MessageOrigin.user,
    text: 'Puoi consigliarmi un buon libro di fantascienza?',
    attachments: const [],
  ),
  ChatMessage(
    id: '13',
    origin: MessageOrigin.llm,
    text: 'Certo! "Dune" di Frank Herbert è un classico della fantascienza.',
    attachments: const [],
  ),
  ChatMessage(
    id: '14',
    origin: MessageOrigin.user,
    text: 'Che tempo fa oggi a Roma?',
    attachments: const [],
  ),
  ChatMessage(
    id: '15',
    origin: MessageOrigin.llm,
    text: 'Oggi a Roma è previsto tempo soleggiato con temperature miti.',
    attachments: const [],
  ),
  ChatMessage(
    id: '16',
    origin: MessageOrigin.user,
    text:
        'Mi puoi spiegare la differenza tra intelligenza artificiale e machine learning?',
    attachments: const [],
  ),
  ChatMessage(
    id: '17',
    origin: MessageOrigin.llm,
    text:
        'L’intelligenza artificiale è un campo più ampio che include il machine learning, che si concentra sull’apprendimento automatico dai dati.',
    attachments: const [],
  ),
  ChatMessage(
    id: '18',
    origin: MessageOrigin.user,
    text: 'Grazie per le informazioni!',
    attachments: const [],
  ),
  ChatMessage(
    id: '19',
    origin: MessageOrigin.llm,
    text: 'Di nulla! Se hai altre domande sono qui per aiutarti.',
    attachments: const [],
  ),
  ChatMessage(
    id: '8',
    origin: MessageOrigin.user,
    text:
        'Vediamo come si comporta con messaggi molto lunghi che probabilmente sforano la larghezza disponibile dello schemo e per vedere come e quando va a capo nella stessa riga del messaggio....questa è una prova',
    attachments: const [],
  ),
  ChatMessage(
    id: '9',
    origin: MessageOrigin.llm,
    text:
        'Vediamo come si comporta con messaggi molto lunghi che probabilmente sforano la larghezza disponibile dello schemo e per vedere come e quando va a capo nella stessa riga del messaggio....questa è una prova',
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
  ChatMessage(
    id: '9',
    origin: MessageOrigin.llm,
    text: null,
    statusMessage: 'Sto elaborando la tua richiesta...',
    attachments: const [],
  ),
  ChatMessage(
    id: '9',
    origin: MessageOrigin.llm,
    text: 'questo è il risultato',
    statusMessage: 'Sto elaborando la tua richiesta...',
    attachments: const [],
  ),
];
