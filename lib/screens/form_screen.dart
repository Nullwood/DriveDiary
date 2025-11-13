import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _carModelController = TextEditingController();
  final _commentController = TextEditingController();

  String _name = "Паша";

  void _setName(String newName) {
    setState(() {
      _name = newName;
      saveData();
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _carModelController.dispose();
    _commentController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text;
      final email = _emailController.text;
      final car = _carModelController.text;
      final comment = _commentController.text;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Заявка отправлена!\n'
            'Имя: $name\n'
            'Email: $email\n'
            'Автомобиль: $car\n'
            'Комментарий: $comment',
          ),
          backgroundColor: Colors.green.shade700,
        ),
      );

      // Очистим поля после отправки
      _nameController.clear();
      _emailController.clear();
      _carModelController.clear();
      _commentController.clear();
    }
  }

  Future<void> saveData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("name", _name);
  }

  Future<void> loadData() async {
    final prefs = await SharedPreferences.getInstance();
    String value = prefs.getString("name") ?? "Паша";

    _setName(value);
  }

  @override
  void initState() {
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Запись в автосервис'),
        backgroundColor: const Color.fromARGB(255, 180, 180, 180),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(_name),
              Row(children: [
                ElevatedButton(onPressed: () => _setName('Джон'), child: const Text('Джон')),
                ElevatedButton(onPressed: () => _setName('Макс'), child: const Text('Макс')),
                ElevatedButton(onPressed: () => _setName('Раян'), child: const Text('Раян'))
              ],),
              const Text(
                'Оставьте заявку, и мы свяжемся с вами для уточнения деталей.',
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
              const SizedBox(height: 24),

              // Имя
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Ваше имя',
                  hintText: 'Введите имя',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Введите имя';
                  } else if (value.length < 2) {
                    return 'Слишком короткое имя';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Email
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email для связи',
                  hintText: 'Введите адрес электронной почты',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Введите email';
                  }
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                      .hasMatch(value)) {
                    return 'Введите корректный email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Модель автомобиля
              TextFormField(
                controller: _carModelController,
                decoration: const InputDecoration(
                  labelText: 'Модель автомобиля',
                  hintText: 'Например: Nissan Skyline R34',
                  prefixIcon: Icon(Icons.directions_car),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Введите модель автомобиля';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Комментарий
              TextFormField(
                controller: _commentController,
                decoration: const InputDecoration(
                  labelText: 'Комментарий / желаемая услуга',
                  hintText: 'Например: замена выхлопа, чип-тюнинг...',
                  prefixIcon: Icon(Icons.build),
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 24),

              // Кнопка отправки
              Center(
                child: ElevatedButton.icon(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 180, 180, 180),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  icon: const Icon(Icons.send),
                  label: const Text(
                    'Отправить заявку',
                    style: TextStyle(fontSize: 16, color: Color.fromARGB(255, 0, 0, 0)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
