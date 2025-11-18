import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Message Input Widget
/// Contains TextField for typing and Send button
class MessageInput extends StatefulWidget {
  final Function(String) onSendMessage;

  const MessageInput({
    Key? key,
    required this.onSendMessage,
  }) : super(key: key);

  @override
  State<MessageInput> createState() => _MessageInputState();
}

class _MessageInputState extends State<MessageInput> {
  final TextEditingController _messageController = TextEditingController();
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    // Listen to text changes to enable/disable send button
    _messageController.addListener(() {
      setState(() {
        _hasText = _messageController.text.trim().isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  /// Handle send button press
  void _handleSendMessage() {
    final text = _messageController.text.trim();
    if (text.isNotEmpty) {
      widget.onSendMessage(text);
      _messageController.clear();
      // Unfocus keyboard after sending
      FocusScope.of(context).unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: AppTheme.inputBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            // Emoji button (optional - can add functionality later)
            IconButton(
              icon: const Icon(Icons.emoji_emotions_outlined),
              color: Colors.grey,
              onPressed: () {
                // TODO: Add emoji picker functionality
              },
            ),

            // Text input field
            Expanded(
              child: TextField(
                controller: _messageController,
                decoration: const InputDecoration(
                  hintText: 'Type a message...',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                ),
                maxLines: null,
                textInputAction: TextInputAction.send,
                onSubmitted: (_) => _handleSendMessage(),
              ),
            ),

            // Attachment button (optional - can add functionality later)
            IconButton(
              icon: const Icon(Icons.attach_file),
              color: Colors.grey,
              onPressed: () {
                // TODO: Add file attachment functionality
              },
            ),

            // Send button
            Container(
              decoration: BoxDecoration(
                color: _hasText
                    ? AppTheme.primaryColor
                    : Colors.grey.shade300,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: const Icon(Icons.send),
                color: Colors.white,
                onPressed: _hasText ? _handleSendMessage : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
