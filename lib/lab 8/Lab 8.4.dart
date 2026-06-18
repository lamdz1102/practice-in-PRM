import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Lab84ApiServiceScreen extends StatefulWidget {
  const Lab84ApiServiceScreen({super.key});

  @override
  State<Lab84ApiServiceScreen> createState() => _Lab84ApiServiceScreenState();
}

class _Lab84ApiServiceScreenState extends State<Lab84ApiServiceScreen> {
  late final ApiService _apiService;
  late Future<List<Post>> _futurePosts;

  @override
  void initState() {
    super.initState();
    _apiService = ApiService();
    _futurePosts = _apiService.fetchPosts();
  }

  Future<void> _refreshPosts() async {
    setState(() {
      _futurePosts = _apiService.fetchPosts();
    });
  }

  void _openDetail(Post post) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ApiServicePostDetailScreen(post: post),
      ),
    );
  }

  void _openCreatePostScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CreatePostWithServiceScreen(
          apiService: _apiService,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _apiService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lab 8.4 - ApiService'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Post>>(
        future: _futurePosts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Error: ${snapshot.error}',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton.icon(
                      onPressed: _refreshPosts,
                      icon: const Icon(Icons.refresh),
                      label: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            );
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No posts'));
          }

          final posts = snapshot.data!;

          return RefreshIndicator(
            onRefresh: _refreshPosts,
            child: ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];

                return ListTile(
                  leading: CircleAvatar(
                    child: Text(post.id.toString()),
                  ),
                  title: Text(post.title),
                  subtitle: Text(
                    post.body,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  onTap: () => _openDetail(post),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openCreatePostScreen,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class ApiService {
  final http.Client _client;

  ApiService({http.Client? client}) : _client = client ?? http.Client();

  final String _baseUrl = 'https://jsonplaceholder.typicode.com';

  Future<List<Post>> fetchPosts() async {
    final url = Uri.parse('$_baseUrl/posts');
    final response = await _client.get(url);

    if (response.statusCode != 200) {
      throw Exception('Failed to load posts: ${response.statusCode}');
    }

    final List<dynamic> jsonList = json.decode(response.body);

    return jsonList.map((jsonItem) {
      return Post.fromJson(jsonItem);
    }).toList();
  }

  Future<Post> createPost({
    required String title,
    required String body,
    required int userId,
  }) async {
    final url = Uri.parse('$_baseUrl/posts');

    final response = await _client.post(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode({
        'title': title,
        'body': body,
        'userId': userId,
      }),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to create post: ${response.statusCode}');
    }

    final Map<String, dynamic> jsonMap = json.decode(response.body);

    return Post.fromJson(jsonMap);
  }

  void dispose() {
    _client.close();
  }
}

class Post {
  final int id;
  final int userId;
  final String title;
  final String body;

  Post({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'] as int,
      userId: json['userId'] as int,
      title: json['title'] as String,
      body: json['body'] as String,
    );
  }
}

class ApiServicePostDetailScreen extends StatelessWidget {
  final Post post;

  const ApiServicePostDetailScreen({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post #${post.id}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Text(
              post.title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            Text('User ID: ${post.userId}'),

            const SizedBox(height: 20),

            Text(
              post.body,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

class CreatePostWithServiceScreen extends StatefulWidget {
  final ApiService apiService;

  const CreatePostWithServiceScreen({
    super.key,
    required this.apiService,
  });

  @override
  State<CreatePostWithServiceScreen> createState() =>
      _CreatePostWithServiceScreenState();
}

class _CreatePostWithServiceScreenState
    extends State<CreatePostWithServiceScreen> {
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();

  bool _isLoading = false;
  String? _errorMessage;
  Post? _createdPost;

  Future<void> _submitPost() async {
    final title = _titleController.text.trim();
    final body = _bodyController.text.trim();

    if (title.isEmpty || body.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter title and body'),
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _createdPost = null;
    });

    try {
      final post = await widget.apiService.createPost(
        title: title,
        body: body,
        userId: 1,
      );

      setState(() {
        _createdPost = post;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final buttonChild = _isLoading
        ? const SizedBox(
      width: 18,
      height: 18,
      child: CircularProgressIndicator(strokeWidth: 2),
    )
        : const Text('Create Post');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            TextField(
              controller: _titleController,
              enabled: !_isLoading,
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: _bodyController,
              enabled: !_isLoading,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: 'Body',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            ElevatedButton(
              onPressed: _isLoading ? null : _submitPost,
              child: buttonChild,
            ),

            const SizedBox(height: 24),

            if (_errorMessage != null) ...[
              Text(
                'Error: $_errorMessage',
                style: const TextStyle(color: Colors.red),
              ),
              const SizedBox(height: 8),
              OutlinedButton.icon(
                onPressed: _isLoading ? null : _submitPost,
                icon: const Icon(Icons.refresh),
                label: const Text('Retry'),
              ),
            ],

            if (_createdPost != null) ...[
              const Text(
                'Created post:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 8),
              Text('ID: ${_createdPost!.id}'),
              Text('User ID: ${_createdPost!.userId}'),
              Text('Title: ${_createdPost!.title}'),
              Text('Body: ${_createdPost!.body}'),
            ],
          ],
        ),
      ),
    );
  }
}