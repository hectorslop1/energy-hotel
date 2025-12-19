import 'package:flutter/material.dart';
import 'dart:async';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/formatters.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<ChatMessage> _messages = [];
  bool _isTyping = false;

  final List<String> _quickReplies = [
    'Room service menu',
    'WiFi password',
    'Pool hours',
    'Request late checkout',
    'Book a restaurant',
  ];

  @override
  void initState() {
    super.initState();
    _addWelcomeMessage();
  }

  void _addWelcomeMessage() {
    _messages.add(
      ChatMessage(
        id: '0',
        text:
            'Hello! 👋 Welcome to Energy Hotel. I\'m your virtual concierge. How can I assist you today?',
        isFromUser: false,
        timestamp: DateTime.now(),
      ),
    );
  }

  void _sendMessage(String text) {
    if (text.trim().isEmpty) return;

    setState(() {
      _messages.add(
        ChatMessage(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          text: text,
          isFromUser: true,
          timestamp: DateTime.now(),
        ),
      );
      _isTyping = true;
    });

    _messageController.clear();
    _scrollToBottom();

    // Simulate bot response
    Timer(const Duration(milliseconds: 1500), () {
      if (mounted) {
        setState(() {
          _isTyping = false;
          _messages.add(
            ChatMessage(
              id: DateTime.now().millisecondsSinceEpoch.toString(),
              text: _getBotResponse(text),
              isFromUser: false,
              timestamp: DateTime.now(),
            ),
          );
        });
        _scrollToBottom();
      }
    });
  }

  String _getBotResponse(String userMessage) {
    final message = userMessage.toLowerCase();

    if (message.contains('wifi') || message.contains('internet')) {
      return 'Your WiFi credentials:\n\n📶 Network: EnergyHotel_Guest\n🔑 Password: Welcome2024!\n\nConnect and enjoy complimentary high-speed internet throughout the property.';
    } else if (message.contains('pool')) {
      return 'Our pool is open daily:\n\n🏊 Main Pool: 7:00 AM - 10:00 PM\n🌴 Adults Only Pool: 9:00 AM - 8:00 PM\n\nTowels are available at the pool deck. Would you like to reserve a cabana?';
    } else if (message.contains('checkout') ||
        message.contains('check out') ||
        message.contains('check-out')) {
      return 'Standard checkout is at 11:00 AM. I can request a late checkout for you:\n\n⏰ Until 1:00 PM - Complimentary (subject to availability)\n⏰ Until 3:00 PM - \$50 fee\n⏰ Until 6:00 PM - \$100 fee\n\nWould you like me to request a late checkout?';
    } else if (message.contains('room service') ||
        message.contains('menu') ||
        message.contains('food')) {
      return 'Room service is available 24/7! 🍽️\n\nYou can browse our full menu and place orders directly through the app. Just tap on "Room Service" in Quick Actions on the home screen.\n\nPopular items:\n• American Breakfast - \$28\n• Club Sandwich - \$22\n• Gourmet Burger - \$26';
    } else if (message.contains('restaurant') ||
        message.contains('dining') ||
        message.contains('dinner')) {
      return 'We have 5 amazing restaurants:\n\n🌊 La Terraza - Mediterranean (6-11 PM)\n🍣 Sakura - Japanese (12-10 PM)\n🌮 El Jardín - Mexican (7 AM-10 PM)\n🥩 The Grill House - Steakhouse (5-11 PM)\n🍹 Pool Bar - Casual (10 AM-8 PM)\n\nWould you like me to make a reservation?';
    } else if (message.contains('spa')) {
      return 'Our spa is open daily from 9:00 AM to 9:00 PM. 💆\n\nPopular treatments:\n• Swedish Massage (60 min) - \$120\n• Deep Tissue (60 min) - \$140\n• Couples Package (90 min) - \$350\n\nYou can book directly through the Spa section in Quick Actions!';
    } else if (message.contains('gym') || message.contains('fitness')) {
      return 'Our fitness center is open 24/7 for hotel guests! 💪\n\nLocation: 2nd Floor\nEquipment: Cardio machines, free weights, yoga studio\nPersonal training available upon request.\n\nDon\'t forget your room key for access!';
    } else if (message.contains('parking') || message.contains('valet')) {
      return 'Parking options:\n\n🚗 Self-parking: \$25/day\n🎩 Valet parking: \$40/day\n\nValet is available 24/7 at the main entrance. Would you like me to request your car?';
    } else if (message.contains('airport') ||
        message.contains('shuttle') ||
        message.contains('transport')) {
      return 'Transportation services:\n\n✈️ Airport Shuttle: \$35 per person\n🚕 Private Car: \$75 (up to 4 guests)\n🚐 SUV/Van: \$95 (up to 7 guests)\n\nPlease book at least 4 hours in advance. Would you like to schedule a pickup?';
    } else if (message.contains('hello') ||
        message.contains('hi') ||
        message.contains('hey')) {
      return 'Hello! How can I help you today? Feel free to ask about:\n\n• Hotel amenities & hours\n• Restaurant reservations\n• Spa bookings\n• Transportation\n• Room requests\n\nOr anything else you need!';
    } else if (message.contains('thank')) {
      return 'You\'re welcome! 😊 Is there anything else I can help you with?';
    } else {
      return 'I\'d be happy to help with that! For immediate assistance, you can also:\n\n📞 Call the front desk: Dial 0\n🛎️ Request in-person service\n\nIs there something specific I can look up for you?';
    }
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.support_agent,
                color: AppColors.primary,
                size: 24,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Concierge',
                  style: AppTextStyles.titleMedium.copyWith(
                    color: Colors.white,
                  ),
                ),
                Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: AppColors.success,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Online',
                      style: AppTextStyles.caption.copyWith(
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.phone),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(AppLocalizations.of(context)!.callingFrontDesk),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(AppSpacing.md),
              itemCount: _messages.length + (_isTyping ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == _messages.length && _isTyping) {
                  return _buildTypingIndicator();
                }
                return _buildMessageBubble(_messages[index]);
              },
            ),
          ),
          _buildQuickReplies(),
          _buildInputBar(),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(ChatMessage message) {
    return Align(
      alignment: message.isFromUser
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        margin: const EdgeInsets.only(bottom: AppSpacing.sm),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: message.isFromUser ? AppColors.primary : AppColors.surface,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(AppSpacing.borderRadius),
            topRight: const Radius.circular(AppSpacing.borderRadius),
            bottomLeft: Radius.circular(
              message.isFromUser ? AppSpacing.borderRadius : 4,
            ),
            bottomRight: Radius.circular(
              message.isFromUser ? 4 : AppSpacing.borderRadius,
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryWithOpacity(0.05),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message.text,
              style: AppTextStyles.bodyMedium.copyWith(
                color: message.isFromUser
                    ? Colors.white
                    : AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              Formatters.date(message.timestamp, format: 'h:mm a'),
              style: AppTextStyles.caption.copyWith(
                color: message.isFromUser
                    ? Colors.white60
                    : AppColors.textTertiary,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTypingIndicator() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: AppSpacing.sm),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppSpacing.borderRadius),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [_buildDot(0), _buildDot(1), _buildDot(2)],
        ),
      ),
    );
  }

  Widget _buildDot(int index) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: Duration(milliseconds: 600 + (index * 200)),
      builder: (context, value, child) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 2),
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: AppColors.textTertiary.withValues(
              alpha: 0.3 + (value * 0.7),
            ),
            shape: BoxShape.circle,
          ),
        );
      },
    );
  }

  Widget _buildQuickReplies() {
    return SizedBox(
      height: 44,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
        itemCount: _quickReplies.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: AppSpacing.sm),
            child: ActionChip(
              label: Text(_quickReplies[index]),
              labelStyle: AppTextStyles.labelSmall.copyWith(
                color: AppColors.primary,
              ),
              backgroundColor: AppColors.primaryWithOpacity(0.1),
              side: BorderSide.none,
              onPressed: () => _sendMessage(_quickReplies[index]),
            ),
          );
        },
      ),
    );
  }

  Widget _buildInputBar() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryWithOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _messageController,
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.typeMessage,
                  hintStyle: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textTertiary,
                  ),
                  filled: true,
                  fillColor: AppColors.surfaceVariant,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      AppSpacing.borderRadiusXl,
                    ),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.sm,
                  ),
                ),
                onSubmitted: _sendMessage,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            GestureDetector(
              onTap: () => _sendMessage(_messageController.text),
              child: Container(
                padding: const EdgeInsets.all(AppSpacing.sm),
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.send, color: Colors.white, size: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatMessage {
  final String id;
  final String text;
  final bool isFromUser;
  final DateTime timestamp;

  ChatMessage({
    required this.id,
    required this.text,
    required this.isFromUser,
    required this.timestamp,
  });
}
