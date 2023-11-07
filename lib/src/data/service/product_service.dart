import 'package:screenshotsample/src/data/model/inventory.dart';
import 'package:screenshotsample/src/data/model/product.dart';

class ProductService {
  List<Product> listProduct = [
    Product(
        id: "1",
        title: "Vasant Apparel",
        description: "Đẹp",
        price: 200.000,
        amountProduct: 10,
        createAt: "10/10/2021",
        isLike: false,
        urlImage: [
          'https://cafefcdn.com/thumb_w/650/2019/6/4/5069g-3x2-forever-in-florals-768x512-1559636365541203324963-crop-15596363709051973797845.jpg'
        ],
        category: "Summer Wear",
        inventory: [
          Inventory(
            id: "1",
            color: "Red",
            size: "M",
            stockQuantity: 10,
          ),
          Inventory(
            id: "2",
            color: "Blue",
            size: "S",
            stockQuantity: 2,
          ),
          Inventory(
            id: "4",
            color: "Green",
            size: "S",
            stockQuantity: 1,
          ),
          Inventory(
            id: "5",
            color: "Yellow",
            size: "XL",
            stockQuantity: 5,
          ),
        ]),
    Product(
        id: "2",
        title: "Dhakre fashion",
        description: "Đẹp 1",
        price: 350.000,
        amountProduct: 2,
        createAt: "21/2/2020",
        isLike: false,
        urlImage: [
          'https://img.freepik.com/premium-photo/indian-couple-with-shopping-bags-gift-boxes-standing-isolated-white-background_466689-40850.jpg?size=626&ext=jpg&ga=GA1.1.292346486.1699017504&semt=sph'
        ],
        category: "Teens",
        inventory: [
          Inventory(
            id: "8",
            color: "Red",
            size: "M",
            stockQuantity: 10,
          ),
          Inventory(
            id: "9",
            color: "Blue",
            size: "XL",
            stockQuantity: 2,
          ),
        ]),
    Product(
        id: "3",
        title: "Tanish",
        description: "Đẹp 2",
        price: 200.000,
        amountProduct: 2,
        createAt: "10/10/2012",
        isLike: false,
        urlImage: [
          'https://img.freepik.com/free-photo/portrait-young-female-with-shopping-bags-jumping_23-2148883664.jpg?size=626&ext=jpg&ga=GA1.1.292346486.1699017504&semt=sph'
        ],
        category: "Daily wear"),
    Product(
        id: "4",
        title: "Heartloom",
        description: "Đẹp 3",
        price: 210.000,
        amountProduct: 10,
        createAt: "10/10/2029",
        isLike: false,
        urlImage: [
          'https://img.freepik.com/free-photo/two-beautiful-women-shopping-town_1303-16431.jpg?size=626&ext=jpg&ga=GA1.1.292346486.1699017504&semt=sph'
        ],
        category: "Party wear"),
    Product(
        id: "5",
        title: "Aradhna",
        description: "Đẹp 4",
        price: 500.000,
        amountProduct: 10,
        createAt: "10/10/2014",
        isLike: false,
        urlImage: [
          'https://img.freepik.com/free-photo/full-length-portrait-excited-family_171337-2280.jpg?size=626&ext=jpg&ga=GA1.1.292346486.1699017504&semt=sph'
        ],
        category: "Traditional wear"),
    Product(
        id: "6",
        title: "Glorious",
        description: "Đẹp 5 ",
        price: 150.000,
        amountProduct: 2,
        createAt: "10/10/2011",
        isLike: false,
        urlImage: [
          'https://vcdn1-giaitri.vnecdn.net/2015/04/23/1-4854-1429761605.jpg?w=0&h=0&q=100&dpr=2&fit=crop&s=Bp8MxcmkYfVaR4Hvlg9qAg'
        ],
        category: "Trend wear"),
    Product(
        id: "7",
        title: "Vishudh",
        description: "Đẹp 6 ",
        price: 520.000,
        amountProduct: 10,
        createAt: "24/02/2012",
        isLike: false,
        urlImage: [
          'https://img.freepik.com/free-photo/this-is-same-shoes_329181-1769.jpg?size=626&ext=jpg'
        ],
        category: "Office wear"),
  ];

  Future<List<Product>> getListProduct() async {
    return listProduct;
  }

// Future likeProduct(int isLike) async {
//   if (isLike == 0) {
//     isLike = 1;
//
//   }
// }
}
