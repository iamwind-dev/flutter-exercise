import 'package:flutter/material.dart';
import '../models/message_model.dart';
import '../widgets/message_bubble.dart';
import '../widgets/message_input.dart';
import '../theme/app_theme.dart';

/// Chat Screen
/// Main chat interface with AppBar, message list, and input area
class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  // List to store all messages
  final List<Message> _messages = [];
  
  // ScrollController to auto-scroll to latest message
  final ScrollController _scrollController = ScrollController();

  // Bot is typing indicator
  bool _isBotTyping = false;

  @override
  void initState() {
    super.initState();
    // Add initial welcome message from bot
    _addBotMessage('Hey! I\'m your AI Bot. How can I help you today? 😊');
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  /// Scroll to the bottom of the message list
  void _scrollToBottom() {
    // Use addPostFrameCallback to ensure the list is built before scrolling
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  /// Add user message to the list
  void _handleSendMessage(String text) {
    setState(() {
      _messages.add(Message(
        sender: 'You',
        text: text,
        timestamp: DateTime.now(),
        isUser: true,
      ));
    });

    // Scroll to bottom after adding message
    _scrollToBottom();

    // Trigger bot auto-reply after 1 second
    _generateBotReply(text);
  }

  /// Generate automatic bot reply
  void _generateBotReply(String userMessage) {
    setState(() {
      _isBotTyping = true;
    });

    // Simulate bot thinking/typing delay
    Future.delayed(const Duration(seconds: 1), () {
      if (!mounted) return;

      // Generate simple contextual replies
      String botReply = _getBotResponse(userMessage);

      setState(() {
        _isBotTyping = false;
        _addBotMessage(botReply);
      });

      // Scroll to bottom after bot reply
      _scrollToBottom();
    });
  }

  /// Add bot message to the list
  void _addBotMessage(String text) {
    _messages.add(Message(
      sender: 'AI Bot',
      text: text,
      timestamp: DateTime.now(),
      isUser: false,
    ));
  }

  /// Get bot response based on user message
  String _getBotResponse(String userMessage) {
    final lowerMessage = userMessage.toLowerCase();

    // Simple response logic
    if (lowerMessage.contains('hello') || lowerMessage.contains('hi')) {
      return 'Hello! How are you doing? 👋';
    } else if (lowerMessage.contains('how are you')) {
      return 'I\'m doing great, thanks for asking! How about you? 😊';
    } else if (lowerMessage.contains('bye') || lowerMessage.contains('goodbye')) {
      return 'Goodbye! Have a great day! 👋';
    } else if (lowerMessage.contains('help')) {
      return 'Sure! I\'m here to chat with you. Just type anything and I\'ll respond! 🤖';
    } else if (lowerMessage.contains('thank')) {
      return 'You\'re welcome! Happy to help! 😊';
    } else if (lowerMessage.contains('?')) {
      return 'That\'s an interesting question! Let me think... 🤔';
    } else {
      // Default responses
      final responses = [
        'Got it! 👍',
        'Interesting! Tell me more! 😊',
        'I see what you mean! 💭',
        'That\'s cool! 🎉',
        'Understood! ✓',
        'Makes sense! 👌',
      ];
      responses.shuffle();
      return responses.first;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      
      // AppBar with profile info
      appBar: AppBar(
        titleSpacing: 0,
        title: Row(
          children: [
            // Bot avatar
            Stack(
              children: [
                const CircleAvatar(
                  radius: 20,
                  backgroundColor: AppTheme.primaryColor,
                  child: Icon(
                    Icons.smart_toy,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                // Online indicator
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 14,
                    height: 14,
                    decoration: BoxDecoration(
                      color: AppTheme.onlineIndicatorColor,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                        width: 2,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 12),
            
            // Bot name and status
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'AI Bot',
                    style: AppTheme.senderNameText,
                  ),
                  Text(
                    'Active now',
                    style: AppTheme.timestampText.copyWith(fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          // Optional: Video call button
          IconButton(
            icon: const Icon(Icons.videocam),
            onPressed: () {
              // TODO: Add video call functionality
            },
          ),
          // Optional: Phone call button
          IconButton(
            icon: const Icon(Icons.phone),
            onPressed: () {
              // TODO: Add phone call functionality
            },
          ),
          // Optional: More options
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              // TODO: Add info/settings
            },
          ),
        ],
      ),

      // Chat messages area
      body: Column(
        children: [
          // Messages list
          Expanded(
            child: _messages.isEmpty
                ? Center(
                    child: Text(
                      'No messages yet',
                      style: AppTheme.timestampText,
                    ),
                  )
                : ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    itemCount: _messages.length + (_isBotTyping ? 1 : 0),
                    itemBuilder: (context, index) {
                      // Show typing indicator as last item
                      if (_isBotTyping && index == _messages.length) {
                        return _buildTypingIndicator();
                      }
                      
                      // Show message bubble
                      return MessageBubble(message: _messages[index]);
                    },
                  ),
          ),

          // Message input area
          MessageInput(onSendMessage: _handleSendMessage),
        ],
      ),
    );
  }

  /// Build typing indicator widget
  Widget _buildTypingIndicator() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Row(
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: AppTheme.primaryColor,
            child: const Icon(
              Icons.smart_toy,
              size: 18,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: AppTheme.friendBubbleColor,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildTypingDot(0),
                const SizedBox(width: 4),
                _buildTypingDot(1),
                const SizedBox(width: 4),
                _buildTypingDot(2),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Build animated typing dot
  Widget _buildTypingDot(int index) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 600),
      builder: (context, value, child) {
        final delay = index * 0.2;
        final animValue = (value + delay) % 1.0;
        final opacity = (animValue < 0.5) ? animValue * 2 : (1 - animValue) * 2;
        
        return Opacity(
          opacity: opacity.clamp(0.3, 1.0),
          child: Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: Colors.grey,
              shape: BoxShape.circle,
            ),
          ),
        );
      },
      onEnd: () {
        if (_isBotTyping && mounted) {
          setState(() {}); // Restart animation
        }
      },
    );
  }
}
