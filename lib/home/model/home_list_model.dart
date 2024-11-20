class HomeListModel {
  final String title;
  final String category;
  final DateTime createdAt;
  final List<String> tags;
  final int price;
  HomeListModel({
    required this.title,
    required this.category,
    required this.createdAt,
    required this.tags,
    required this.price,
  });

  static List<HomeListModel> dummyHomeList = [
    HomeListModel(
      title: "4P 마케팅 레포트 과제",
      category: "시험/ 과제",
      createdAt: DateTime(2024, 11, 11),
      tags: ["마케팅", "가톨릭대", "레포트"],
      price: 1000,
    ),
    HomeListModel(
      title: "인공지능 프로젝트 발표",
      category: "프로젝트",
      createdAt: DateTime(2024, 12, 1),
      tags: ["AI", "발표", "팀프로젝트"],
      price: 2000,
    ),
    HomeListModel(
      title: "영어 논문 번역",
      category: "번역",
      createdAt: DateTime(2024, 11, 25),
      tags: ["영어", "번역", "논문"],
      price: 1500,
    ),
    HomeListModel(
      title: "소프트웨어 공학 기말고사",
      category: "시험",
      createdAt: DateTime(2024, 12, 10),
      tags: ["소프트웨어", "공학", "시험"],
      price: 500,
    ),
    HomeListModel(
      title: "디자인 포트폴리오 작성",
      category: "포트폴리오",
      createdAt: DateTime(2024, 11, 30),
      tags: ["디자인", "포트폴리오", "작성"],
      price: 1200,
    ),
  ];
}
