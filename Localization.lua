local _, gc = ...

gc.L = {}

local L = gc.L

local LOCALE = GetLocale()

if LOCALE == "enUS" then
	L["ButtonSpeechTT"] = "Start/Stop Text To Speech Playback"
	L["Setting_General"] = GENERAL
	L["Setting_SplitParagraphs"] = "Split Paragraphs"
	L["Setting_SplitParagraphsTT"] = "Print each paragraph as its own chat message instead of a single block."
	L["Setting_IndentParagraphs"] = "Indent Paragraphs"
	L["Setting_IndentParagraphsTT"] = "Each split paragraph starts with an indent in the chat log."
	L["Setting_OutputChatFrame"] = "Output Chat Frame"
	L["Setting_OutputChatFrameTT"] = "Choose which chat frame to output text to."
	L["Setting_TextToSpeech"] = TEXT_TO_SPEECH
	L["Setting_ShowButton"] = "Show Button on Frames"
	L["Setting_ShowButtonTT"] = "Show the Text To Speech button on gossip, quest, and text item frames."
	L["Setting_AutoplayTTS"] = "Auto-play Text To Speech"
	L["Setting_AutoplayTTSTT"] = "Automatically play gossip text with Text to Speech."
	L["Setting_InterruptTTS"] = "Interrupt Text To Speech"
	L["Setting_InterruptTTSTT"] = "Interrupt Text To Speech if you close a gossip, quest, or text item frame."
	L["Setting_FormatName"] = "Format Creature Name"
	L["Setting_FormatNameTT"] = "Prefix Text To Speech messages with the Creature name."
	L["Setting_VoiceOptions"] = VOICE_CHAT_OPTIONS
	L["Setting_Voice_They"] = "They/Them"
	L["Setting_Voice_He"] = "He/Him"
	L["Setting_Voice_She"] = "She/Her"
	L["Setting_Voice_Unk"] = "Item/Unknown"
	L["Setting_Voice_Rate"] = "Rate"
	L["Setting_Voice_Volume"] = "Volume"
	L["Setting_Voice_VoiceID"] = "Voice"
	L["Setting_Voice_DropdownTT"] = "Voice selection for %s"
	L["Setting_Voice_PlaySample"] = "Play Sample: %s"
	L["Setting_Voice_PlaySampleTT"] = "Hear an example of this voice with current settings."

	L["Title_TOC"] = "Gossip Chatter"
	L["Notes_TOC"] = "Prints the gossip / quest text in chat as if an NPC were speaking in /say."

return end

if LOCALE == "esES" or LOCALE == "esMX" then
	-- Spanish translations go here
	L["ButtonSpeechTT"] = "Iniciar/Detener reproducción de Texto a Voz"
	L["Setting_General"] = GENERAL
	L["Setting_SplitParagraphs"] = "Dividir párrafos"
	L["Setting_SplitParagraphsTT"] = "Muestra cada párrafo como un mensaje de chat separado en lugar de un bloque único."
	L["Setting_IndentParagraphs"] = "Sangrar párrafos"
	L["Setting_IndentParagraphsTT"] = "Cada párrafo dividido comienza con una sangría en el chat."
	L["Setting_OutputChatFrame"] = "Marco de chat de salida"
	L["Setting_OutputChatFrameTT"] = "Elige en qué marco de chat mostrar el texto."
	L["Setting_TextToSpeech"] = TEXT_TO_SPEECH
	L["Setting_ShowButton"] = "Mostrar botón en marcos"
	L["Setting_ShowButtonTT"] = "Muestra el botón de Texto a Voz en marcos de rumores, misiones y objetos de texto."
	L["Setting_AutoplayTTS"] = "Reproducción automática de Texto a Voz"
	L["Setting_AutoplayTTSTT"] = "Reproduce automáticamente los rumores con Texto a Voz."
	L["Setting_InterruptTTS"] = "Interrumpir Texto a Voz"
	L["Setting_InterruptTTSTT"] = "Interrumpe el Texto a Voz si cierras un marco de rumor, misión u objeto de texto."
	L["Setting_FormatName"] = "Formatear nombre de criatura"
	L["Setting_FormatNameTT"] = "Anteponer el nombre de la criatura a los mensajes de Texto a Voz."
	L["Setting_VoiceOptions"] = VOICE_CHAT_OPTIONS
	L["Setting_Voice_They"] = "Elle"
	L["Setting_Voice_He"] = "Él"
	L["Setting_Voice_She"] = "Ella"
	L["Setting_Voice_Unk"] = "Objeto/Desconocido"
	L["Setting_Voice_Rate"] = "Velocidad"
	L["Setting_Voice_Volume"] = "Volumen"
	L["Setting_Voice_VoiceID"] = "Voz"
	L["Setting_Voice_DropdownTT"] = "Selección de voz para %s"
	L["Setting_Voice_PlaySample"] = "Reproducir muestra: %s"
	L["Setting_Voice_PlaySampleTT"] = "Escucha un ejemplo de esta voz con la configuración actual."

	L["Title_TOC"] = "Gossip Chatter"
	L["Notes_TOC"] = "Muestra los textos de rumores/misiones en el chat como si un PNJ hablara en /decir."

return end

if LOCALE == "deDE" then
	-- German translations go here
	L["ButtonSpeechTT"] = "Text-to-Speech-Wiedergabe starten/stoppen"
	L["Setting_General"] = GENERAL
	L["Setting_SplitParagraphs"] = "Absätze trennen"
	L["Setting_SplitParagraphsTT"] = "Jeden Absatz als eigene Chatnachricht ausgeben anstatt als Block."
	L["Setting_IndentParagraphs"] = "Absätze einrücken"
	L["Setting_IndentParagraphsTT"] = "Jeder geteilte Absatz beginnt im Chat mit einem Einzug."
	L["Setting_OutputChatFrame"] = "Ausgabe-Chatfenster"
	L["Setting_OutputChatFrameTT"] = "Wähle, in welchem Chatfenster der Text ausgegeben wird."
	L["Setting_TextToSpeech"] = TEXT_TO_SPEECH
	L["Setting_ShowButton"] = "Schaltfläche auf Fenstern anzeigen"
	L["Setting_ShowButtonTT"] = "Zeigt die Text-to-Speech-Schaltfläche auf Gossip-, Quest- und Textobjektfenstern."
	L["Setting_AutoplayTTS"] = "Automatische Wiedergabe von Text-to-Speech"
	L["Setting_AutoplayTTSTT"] = "Spielt automatisch Gossip-Text mit Text-to-Speech ab."
	L["Setting_InterruptTTS"] = "Text-to-Speech unterbrechen"
	L["Setting_InterruptTTSTT"] = "Unterbricht Text-to-Speech, wenn du ein Gossip-, Quest- oder Textobjektfenster schließt."
	L["Setting_FormatName"] = "Kreaturnamen formatieren"
	L["Setting_FormatNameTT"] = "Stellt dem Text-to-Speech-Text den Namen der Kreatur voran."
	L["Setting_VoiceOptions"] = VOICE_CHAT_OPTIONS
	L["Setting_Voice_They"] = "Er/Sie"
	L["Setting_Voice_He"] = "Er"
	L["Setting_Voice_She"] = "Sie"
	L["Setting_Voice_Unk"] = "Objekt/Unbekannt"
	L["Setting_Voice_Rate"] = "Tempo"
	L["Setting_Voice_Volume"] = "Lautstärke"
	L["Setting_Voice_VoiceID"] = "Stimme"
	L["Setting_Voice_DropdownTT"] = "Stimmauswahl für %s"
	L["Setting_Voice_PlaySample"] = "Beispiel abspielen: %s"
	L["Setting_Voice_PlaySampleTT"] = "Höre ein Beispiel dieser Stimme mit den aktuellen Einstellungen."

	L["Title_TOC"] = "Gossip Chatter"
	L["Notes_TOC"] = "Zeigt Gossip-/Questtext im Chat, als ob ein NSC in /sagen spräche."
	
return end

if LOCALE == "frFR" then
	-- French translations go here
	L["ButtonSpeechTT"] = "Démarrer/Arrêter la lecture Texte en Parole"
	L["Setting_General"] = GENERAL
	L["Setting_SplitParagraphs"] = "Diviser les paragraphes"
	L["Setting_SplitParagraphsTT"] = "Affiche chaque paragraphe comme un message distinct plutôt qu’un bloc unique."
	L["Setting_IndentParagraphs"] = "Indenter les paragraphes"
	L["Setting_IndentParagraphsTT"] = "Chaque paragraphe séparé commence avec un retrait dans le chat."
	L["Setting_OutputChatFrame"] = "Fenêtre de chat de sortie"
	L["Setting_OutputChatFrameTT"] = "Choisissez dans quelle fenêtre de chat afficher le texte."
	L["Setting_TextToSpeech"] = TEXT_TO_SPEECH
	L["Setting_ShowButton"] = "Afficher le bouton sur les fenêtres"
	L["Setting_ShowButtonTT"] = "Affiche le bouton Texte en Parole sur les fenêtres de ragots, quêtes et objets texte."
	L["Setting_AutoplayTTS"] = "Lecture automatique Texte en Parole"
	L["Setting_AutoplayTTSTT"] = "Lit automatiquement le texte des ragots avec Texte en Parole."
	L["Setting_InterruptTTS"] = "Interrompre Texte en Parole"
	L["Setting_InterruptTTSTT"] = "Interrompt la lecture si vous fermez une fenêtre de ragot, quête ou objet texte."
	L["Setting_FormatName"] = "Formater le nom de la créature"
	L["Setting_FormatNameTT"] = "Préfixe les messages Texte en Parole avec le nom de la créature."
	L["Setting_VoiceOptions"] = VOICE_CHAT_OPTIONS
	L["Setting_Voice_They"] = "Iel"
	L["Setting_Voice_He"] = "Il"
	L["Setting_Voice_She"] = "Elle"
	L["Setting_Voice_Unk"] = "Objet/Inconnu"
	L["Setting_Voice_Rate"] = "Vitesse"
	L["Setting_Voice_Volume"] = "Volume"
	L["Setting_Voice_VoiceID"] = "Voix"
	L["Setting_Voice_DropdownTT"] = "Sélection de la voix pour %s"
	L["Setting_Voice_PlaySample"] = "Jouer un échantillon : %s"
	L["Setting_Voice_PlaySampleTT"] = "Écoutez un exemple de cette voix avec les paramètres actuels."

	L["Title_TOC"] = "Gossip Chatter"
	L["Notes_TOC"] = "Affiche les textes de ragot/quêtes dans le chat comme si un PNJ parlait en /dire."
	
return end

if LOCALE == "itIT" then
	-- French translations go here
	L["ButtonSpeechTT"] = "Avvia/Interrompi lettura Testo a Voce"
	L["Setting_General"] = GENERAL
	L["Setting_SplitParagraphs"] = "Dividi paragrafi"
	L["Setting_SplitParagraphsTT"] = "Mostra ogni paragrafo come messaggio separato invece di un blocco unico."
	L["Setting_IndentParagraphs"] = "Indenta paragrafi"
	L["Setting_IndentParagraphsTT"] = "Ogni paragrafo diviso inizia con un rientro nella chat."
	L["Setting_OutputChatFrame"] = "Finestra di chat di uscita"
	L["Setting_OutputChatFrameTT"] = "Scegli in quale finestra di chat mostrare il testo."
	L["Setting_TextToSpeech"] = TEXT_TO_SPEECH
	L["Setting_ShowButton"] = "Mostra pulsante nei riquadri"
	L["Setting_ShowButtonTT"] = "Mostra il pulsante Testo a Voce nei riquadri di dialogo, missione e testo."
	L["Setting_AutoplayTTS"] = "Riproduzione automatica Testo a Voce"
	L["Setting_AutoplayTTSTT"] = "Riproduce automaticamente i dialoghi con Testo a Voce."
	L["Setting_InterruptTTS"] = "Interrompi Testo a Voce"
	L["Setting_InterruptTTSTT"] = "Interrompe il Testo a Voce se chiudi un riquadro di dialogo, missione o testo."
	L["Setting_FormatName"] = "Formatta nome creatura"
	L["Setting_FormatNameTT"] = "Anteponi il nome della creatura ai messaggi Testo a Voce."
	L["Setting_VoiceOptions"] = VOICE_CHAT_OPTIONS
	L["Setting_Voice_They"] = "Loro"
	L["Setting_Voice_He"] = "Lui"
	L["Setting_Voice_She"] = "Lei"
	L["Setting_Voice_Unk"] = "Oggetto/Sconosciuto"
	L["Setting_Voice_Rate"] = "Velocità"
	L["Setting_Voice_Volume"] = "Volume"
	L["Setting_Voice_VoiceID"] = "Voce"
	L["Setting_Voice_DropdownTT"] = "Selezione voce per %s"
	L["Setting_Voice_PlaySample"] = "Riproduci campione: %s"
	L["Setting_Voice_PlaySampleTT"] = "Ascolta un esempio di questa voce con le impostazioni attuali."

	L["Title_TOC"] = "Gossip Chatter"
	L["Notes_TOC"] = "Mostra i testi di dialogo/missioni nella chat come se un PNG parlasse in /dire."
	
return end

if LOCALE == "ptBR" then
	-- Brazilian Portuguese translations go here
	L["ButtonSpeechTT"] = "Iniciar/Parar reprodução de Texto para Fala"
	L["Setting_General"] = GENERAL
	L["Setting_SplitParagraphs"] = "Dividir parágrafos"
	L["Setting_SplitParagraphsTT"] = "Mostra cada parágrafo como uma mensagem separada em vez de um único bloco."
	L["Setting_IndentParagraphs"] = "Indentar parágrafos"
	L["Setting_IndentParagraphsTT"] = "Cada parágrafo dividido começa com indentação no chat."
	L["Setting_OutputChatFrame"] = "Janela de chat de saída"
	L["Setting_OutputChatFrameTT"] = "Escolha em qual janela de chat exibir o texto."
	L["Setting_TextToSpeech"] = TEXT_TO_SPEECH
	L["Setting_ShowButton"] = "Mostrar botão nas janelas"
	L["Setting_ShowButtonTT"] = "Mostra o botão Texto para Fala em janelas de fofoca, missão e texto."
	L["Setting_AutoplayTTS"] = "Reprodução automática de Texto para Fala"
	L["Setting_AutoplayTTSTT"] = "Reproduz automaticamente o texto de fofoca com Texto para Fala."
	L["Setting_InterruptTTS"] = "Interromper Texto para Fala"
	L["Setting_InterruptTTSTT"] = "Interrompe Texto para Fala se você fechar uma janela de fofoca, missão ou texto."
	L["Setting_FormatName"] = "Formatar nome da criatura"
	L["Setting_FormatNameTT"] = "Prefixa mensagens de Texto para Fala com o nome da criatura."
	L["Setting_VoiceOptions"] = VOICE_CHAT_OPTIONS
	L["Setting_Voice_They"] = "Elu"
	L["Setting_Voice_He"] = "Ele"
	L["Setting_Voice_She"] = "Ela"
	L["Setting_Voice_Unk"] = "Item/Desconhecido"
	L["Setting_Voice_Rate"] = "Velocidade"
	L["Setting_Voice_Volume"] = "Volume"
	L["Setting_Voice_VoiceID"] = "Voz"
	L["Setting_Voice_DropdownTT"] = "Seleção de voz para %s"
	L["Setting_Voice_PlaySample"] = "Reproduzir amostra: %s"
	L["Setting_Voice_PlaySampleTT"] = "Ouça um exemplo desta voz com as configurações atuais."

	L["Title_TOC"] = "Gossip Chatter"
	L["Notes_TOC"] = "Mostra textos de fofoca/missão no chat como se um PNJ falasse em /dizer."
	
	-- Note that the EU Portuguese WoW client also
	-- uses the Brazilian Portuguese locale code.
return end

if LOCALE == "ruRU" then
	-- Russian translations go here
	L["ButtonSpeechTT"] = "Запуск/остановка озвучивания текста"
	L["Setting_General"] = GENERAL
	L["Setting_SplitParagraphs"] = "Разделять абзацы"
	L["Setting_SplitParagraphsTT"] = "Выводит каждый абзац отдельным сообщением вместо одного блока."
	L["Setting_IndentParagraphs"] = "Отступ абзацев"
	L["Setting_IndentParagraphsTT"] = "Каждый разделённый абзац начинается с отступа в чате."
	L["Setting_OutputChatFrame"] = "Окно чата для вывода"
	L["Setting_OutputChatFrameTT"] = "Выберите окно чата для вывода текста."
	L["Setting_TextToSpeech"] = TEXT_TO_SPEECH
	L["Setting_ShowButton"] = "Показывать кнопку на окнах"
	L["Setting_ShowButtonTT"] = "Показывает кнопку озвучивания текста на окнах диалогов, заданий и текстовых предметов."
	L["Setting_AutoplayTTS"] = "Автовоспроизведение озвучивания"
	L["Setting_AutoplayTTSTT"] = "Автоматически озвучивает текст диалога."
	L["Setting_InterruptTTS"] = "Прерывать озвучивание"
	L["Setting_InterruptTTSTT"] = "Прерывает озвучивание, если закрыть окно диалога, задания или текста."
	L["Setting_FormatName"] = "Формат имени существа"
	L["Setting_FormatNameTT"] = "Добавляет имя существа в начало озвучиваемых сообщений."
	L["Setting_VoiceOptions"] = VOICE_CHAT_OPTIONS
	L["Setting_Voice_They"] = "Они"
	L["Setting_Voice_He"] = "Он"
	L["Setting_Voice_She"] = "Она"
	L["Setting_Voice_Unk"] = "Предмет/Неизвестно"
	L["Setting_Voice_Rate"] = "Скорость"
	L["Setting_Voice_Volume"] = "Громкость"
	L["Setting_Voice_VoiceID"] = "Голос"
	L["Setting_Voice_DropdownTT"] = "Выбор голоса для %s"
	L["Setting_Voice_PlaySample"] = "Воспроизвести образец: %s"
	L["Setting_Voice_PlaySampleTT"] = "Прослушать пример этого голоса с текущими настройками."

	L["Title_TOC"] = "Gossip Chatter"
	L["Notes_TOC"] = "Выводит текст диалогов/заданий в чат, как если бы НИП говорил в /сказать."
	
return end

if LOCALE == "koKR" then
	-- Korean translations go here
	L["ButtonSpeechTT"] = "텍스트 음성 변환 시작/중지"
	L["Setting_General"] = GENERAL
	L["Setting_SplitParagraphs"] = "문단 분할"
	L["Setting_SplitParagraphsTT"] = "각 문단을 하나의 블록 대신 별도의 채팅 메시지로 표시합니다."
	L["Setting_IndentParagraphs"] = "문단 들여쓰기"
	L["Setting_IndentParagraphsTT"] = "분할된 각 문단은 채팅창에서 들여쓰기로 시작합니다."
	L["Setting_OutputChatFrame"] = "출력 채팅창"
	L["Setting_OutputChatFrameTT"] = "텍스트를 출력할 채팅창을 선택합니다."
	L["Setting_TextToSpeech"] = TEXT_TO_SPEECH
	L["Setting_ShowButton"] = "창에 버튼 표시"
	L["Setting_ShowButtonTT"] = "대화, 퀘스트, 텍스트 아이템 창에 음성 변환 버튼을 표시합니다."
	L["Setting_AutoplayTTS"] = "자동 음성 변환"
	L["Setting_AutoplayTTSTT"] = "대화 텍스트를 자동으로 음성으로 재생합니다."
	L["Setting_InterruptTTS"] = "음성 변환 중단"
	L["Setting_InterruptTTSTT"] = "대화, 퀘스트 또는 텍스트 아이템 창을 닫으면 음성 변환을 중단합니다."
	L["Setting_FormatName"] = "생물 이름 형식"
	L["Setting_FormatNameTT"] = "음성 변환 메시지 앞에 생물 이름을 붙입니다."
	L["Setting_VoiceOptions"] = VOICE_CHAT_OPTIONS
	L["Setting_Voice_They"] = "그들"
	L["Setting_Voice_He"] = "그"
	L["Setting_Voice_She"] = "그녀"
	L["Setting_Voice_Unk"] = "아이템/알 수 없음"
	L["Setting_Voice_Rate"] = "속도"
	L["Setting_Voice_Volume"] = "음량"
	L["Setting_Voice_VoiceID"] = "음성"
	L["Setting_Voice_DropdownTT"] = "%s의 음성 선택"
	L["Setting_Voice_PlaySample"] = "샘플 재생: %s"
	L["Setting_Voice_PlaySampleTT"] = "현재 설정으로 이 음성의 예시를 들어봅니다."

	L["Title_TOC"] = "Gossip Chatter"
	L["Notes_TOC"] = "대화/퀘스트 텍스트를 채팅에 출력하여 NPC가 /말하기로 말하는 것처럼 보입니다."
	
return end

if LOCALE == "zhCN" then
	-- Simplified Chinese translations go here
	L["ButtonSpeechTT"] = "开始/停止文字转语音播放"
	L["Setting_General"] = GENERAL
	L["Setting_SplitParagraphs"] = "分段显示"
	L["Setting_SplitParagraphsTT"] = "将每个段落单独作为聊天消息显示，而不是一个整体。"
	L["Setting_IndentParagraphs"] = "段落缩进"
	L["Setting_IndentParagraphsTT"] = "每个分段在聊天记录中以缩进开始。"
	L["Setting_OutputChatFrame"] = "输出聊天窗口"
	L["Setting_OutputChatFrameTT"] = "选择在哪个聊天窗口中显示文本。"
	L["Setting_TextToSpeech"] = TEXT_TO_SPEECH
	L["Setting_ShowButton"] = "在框体上显示按钮"
	L["Setting_ShowButtonTT"] = "在对话、任务和文字物品框体上显示文字转语音按钮。"
	L["Setting_AutoplayTTS"] = "自动播放文字转语音"
	L["Setting_AutoplayTTSTT"] = "自动播放对话文本的语音。"
	L["Setting_InterruptTTS"] = "中断文字转语音"
	L["Setting_InterruptTTSTT"] = "关闭对话、任务或文字物品框体时中断语音。"
	L["Setting_FormatName"] = "格式化生物名称"
	L["Setting_FormatNameTT"] = "在语音消息前加上生物名称。"
	L["Setting_VoiceOptions"] = VOICE_CHAT_OPTIONS
	L["Setting_Voice_They"] = "TA"
	L["Setting_Voice_He"] = "他"
	L["Setting_Voice_She"] = "她"
	L["Setting_Voice_Unk"] = "物品/未知"
	L["Setting_Voice_Rate"] = "语速"
	L["Setting_Voice_Volume"] = "音量"
	L["Setting_Voice_VoiceID"] = "语音"
	L["Setting_Voice_DropdownTT"] = "%s 的语音选择"
	L["Setting_Voice_PlaySample"] = "播放示例: %s"
	L["Setting_Voice_PlaySampleTT"] = "试听当前设置下该语音的示例。"

	L["Title_TOC"] = "Gossip Chatter"
	L["Notes_TOC"] = "在聊天中显示对话/任务文本，就像NPC在/说话中说话一样。"
	
return end

if LOCALE == "zhTW" then
	-- Traditional Chinese translations go here
	L["ButtonSpeechTT"] = "開始/停止文字轉語音播放"
	L["Setting_General"] = GENERAL
	L["Setting_SplitParagraphs"] = "分段顯示"
	L["Setting_SplitParagraphsTT"] = "將每個段落單獨作為聊天訊息顯示，而不是一個整體。"
	L["Setting_IndentParagraphs"] = "段落縮排"
	L["Setting_IndentParagraphsTT"] = "每個分段在聊天紀錄中以縮排開始。"
	L["Setting_OutputChatFrame"] = "輸出聊天視窗"
	L["Setting_OutputChatFrameTT"] = "選擇在哪個聊天視窗中顯示文字。"
	L["Setting_TextToSpeech"] = TEXT_TO_SPEECH
	L["Setting_ShowButton"] = "在框架上顯示按鈕"
	L["Setting_ShowButtonTT"] = "在對話、任務和文字物品框架上顯示文字轉語音按鈕。"
	L["Setting_AutoplayTTS"] = "自動播放文字轉語音"
	L["Setting_AutoplayTTSTT"] = "自動播放對話文字的語音。"
	L["Setting_InterruptTTS"] = "中斷文字轉語音"
	L["Setting_InterruptTTSTT"] = "關閉對話、任務或文字物品框架時中斷語音。"
	L["Setting_FormatName"] = "格式化生物名稱"
	L["Setting_FormatNameTT"] = "在語音訊息前加上生物名稱。"
	L["Setting_VoiceOptions"] = VOICE_CHAT_OPTIONS
	L["Setting_Voice_They"] = "TA"
	L["Setting_Voice_He"] = "他"
	L["Setting_Voice_She"] = "她"
	L["Setting_Voice_Unk"] = "物品/未知"
	L["Setting_Voice_Rate"] = "語速"
	L["Setting_Voice_Volume"] = "音量"
	L["Setting_Voice_VoiceID"] = "語音"
	L["Setting_Voice_DropdownTT"] = "%s 的語音選擇"
	L["Setting_Voice_PlaySample"] = "播放範例: %s"
	L["Setting_Voice_PlaySampleTT"] = "試聽目前設定下該語音的範例。"

	L["Title_TOC"] = "Gossip Chatter"
	L["Notes_TOC"] = "在聊天中顯示對話/任務文字，就像NPC在/說話一樣。"
	
return end