//Excercise 1
// void main(){
//   int age = 10;
//   double b = 10.25;
//   String name = "Lam";
//   bool answer = false;
//   print('points $b');
//   print("Next age : ${age +1} ");
// }

//Excercise 2
// void main(){
//   List<int> num= [1,2,3,4];
//   print(num[1]);
//   int a = 10;
//   int b = 5;
//   print(a+b);
//   print(a<b);
//   Set<String> fruits = {"Apple","Banana","Mango"};
//   print(fruits);
//   Map<String,double> points = {"Math": 10, "Eng" : 8.5};
//   print(points);
//   print("score:   ${points["Math"]}");
// }

Excercise 3
import 'dart:io';
void main(){
  var day = "Monday";
  switch(day){
    case  Monday :
    print('Thu 2');
    break;
    default:
      print('Khong ton tai thu nay');
  }
  print('Nhập điểm: ');
  int score=int.parse(stdin.readLineSync()!);
  if(score<6)
  print('Ban da truot mon');
  else
    print('Ban da qua mon');
  int i;
  for(i=0;i<4;){
    print(i);
    i++;
  }
  List<int> nums = [1,2,3];
  for(var x in nums){
    print(x);
  }
}

//Excercise 4
// class Car {
//   String brand;
//   // Constructor
//   Car(this.brand);
//   // Named constructor
//   Car.electric() : brand = "Tesla";
//   void showInfo() {
//     print("Car brand: $brand");
//   }
// }
//
// class ElectricCar extends Car {
//   ElectricCar(String brand) : super(brand);
//   @override
//   void showInfo() {
//     print("Electric car brand: $brand");
//   }
// }
//
// void main() {
//   Car car1 = Car("Toyota");
//   Car car2 = Car.electric();
//   ElectricCar car3 = ElectricCar("VinFast");
//   car1.showInfo();
//   car2.showInfo();
//   car3.showInfo();
// }
import 'dart:async';

Future<String> fetchData() async {
  await Future.delayed(Duration(seconds: 2));
  return "Dữ liệu đã được tải";
}

Stream<int> counterStream(int max) async* {
  for (int i = 1; i <= max; i++) {
    await Future.delayed(Duration(seconds: 1));
    yield i;
  }
}

void main() async {
  // 1. Future + await
  print("Bắt đầu tải dữ liệu...");
  String data = await fetchData();
  print(data);

  // 2. Null safety
  String? name;
  print(name ?? "Chưa nhập tên"); // Nếu null thì in giá trị mặc định
  name = "Lam";
  print(name!); // chắc chắn không null

  // 3. Stream
  print("Đếm từ 1 đến 5:");
  await for (int i in counterStream(5)) {
    print(i);
  }
}


