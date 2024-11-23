List<String> category = [
    "전체",
    "대외활동",
    "디자인",
    "IT/트렌드",
    "기타",
  ];

  // 서버로 보낼 카테고리 String 반환
  String getCategoryString(String category){
    switch(category){
      case "전체":
        return "전체";
      case "대외활동":
        return "JOB_ACTIVITY";
      case "IT/트렌드":
        return "IT_TREND";
      case "디자인":
        return "DESIGN_TEMPLATE";
      default:
        return "OTHERS";
    }
  }