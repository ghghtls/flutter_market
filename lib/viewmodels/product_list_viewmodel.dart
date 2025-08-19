import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/product.dart';

class ProductListViewModel extends StateNotifier<List<Product>> {
  ProductListViewModel() : super(_dummyProducts);

  static final List<Product> _dummyProducts = [
    Product(
      id: '1',
      name: '김치냉장고',
      price: 20000,
      location: '인천 계양구 귤현동',
      timeAgo: '2시간 전',
      chats: 28,
      likeCount: 8,
      description: '김치냉장고\n판매합니다.',
      sellerName: '미니멀하게',
      sellerTemperature: 39.3,
      imagePath: 'assets/images/sample2.png',
    ),
    Product(
      id: '2',
      name: '샤넬 카드지갑',
      price: 10000,
      location: '수성구 범어동',
      timeAgo: '3시간 전',
      chats: 5,
      likeCount: 19,
      description: '샤넬 카드지갑입니다\n상태 양호합니다',
      sellerName: '샤넬러버',
      sellerTemperature: 42.1,
      imagePath: 'assets/images/sample3.png',
    ),
    Product(
      id: '3',
      name: '금고',
      price: 10000,
      location: '해운대구 우제2동',
      timeAgo: '1일 전',
      chats: 17,
      likeCount: 14,
      description: '안전한 금고입니다\n비밀번호 변경 가능',
      sellerName: '안전지킴이',
      sellerTemperature: 38.7,
      imagePath: 'assets/images/sample4.png',
    ),
    Product(
      id: '4',
      name: '갤럭시Z플립3 팝니다',
      price: 150000,
      location: '연제구 연산제8동',
      timeAgo: '2일 전',
      chats: 9,
      likeCount: 22,
      description: '갤럭시Z플립3 판매합니다\n상태 양호, 액정 깨짐 없음',
      sellerName: '폰마니아',
      sellerTemperature: 41.2,
      imagePath: 'assets/images/sample5.png',
    ),
    Product(
      id: '5',
      name: '프라다 복조리백',
      price: 50000,
      location: '수원시 영통구 원천동',
      timeAgo: '3일 전',
      chats: 16,
      likeCount: 25,
      description: '까임 오염없고 상태 깨끗합니다\n정품여부모름',
      sellerName: '미니멀하게',
      sellerTemperature: 39.3,
      imagePath: 'assets/images/sample6.png',
    ),
    Product(
      id: '6',
      name: '울산 동해오션뷰 60평 복층 펜트하우스 1일 숙박권',
      price: 50000,
      location: '남구 옥동',
      timeAgo: '3일 전',
      chats: 54,
      likeCount: 142,
      description: '울산 동해오션뷰 60평 복층 펜트하우스 1일 숙박권\n울산 동해오션뷰 60평',
      sellerName: '미니멀하게',
      sellerTemperature: 39.3,
      imagePath: 'assets/images/sample7.png',
    ),
  ];

  void deleteProduct(String id) {
    state = state.where((product) => product.id != id).toList();
  }

  void toggleLike(String id) {
    state = state.map((product) {
      if (product.id == id) {
        return product.copyWith(
          isLiked: !product.isLiked,
          likeCount:
              product.isLiked ? product.likeCount - 1 : product.likeCount + 1,
        );
      }
      return product;
    }).toList();
  }
}
