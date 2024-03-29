import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shopping_app/Controllers/cartSharedPref.controller.dart';
import 'package:shopping_app/Controllers/items.controller.dart';
import 'package:shopping_app/Models/cart.model.dart';
import 'package:shopping_app/Models/items.model.dart';
import 'package:shopping_app/Models/user.model.dart';
import 'package:shopping_app/Screens/cart.screen.dart';
import 'package:shopping_app/Utils/bottomSheet.util.dart';

class Details extends StatefulWidget {
  const Details(
      {super.key,
      required this.item,
      required this.userId,
      required this.user});
  final Items item;
  final String userId;
  final User user;

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  int _counter = 1;
  late PageController _pageController;
  int _currentPage = 0;
  ItemController itemController = ItemController();

  void _handleCounterChanged(int newCounter) {
    setState(() {
      _counter = newCounter;
    });
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: _currentPage,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined),
            onPressed: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  // transitionDuration: Duration(milliseconds: 500),
                  pageBuilder: (BuildContext context,
                      Animation<double> animation,
                      Animation<double> secondaryAnimation) {
                    return CartScreen(
                      user: widget.user,
                      userId: widget.userId,
                    );
                  },
                  transitionsBuilder: (_, animation, __, child) {
                    return SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(1.0, 0.0),
                        end: Offset.zero,
                      ).animate(animation),
                      child: child,
                    );
                  },
                ),
              );
              print('Shopping cart'); // Add your profile icon onTap logic here
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                decoration: const BoxDecoration(
                    color: Color.fromARGB(31, 190, 190, 190)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.4,
                      child: Flex(
                        direction: Axis.vertical,
                        children: [
                          Expanded(
                            child: PageView.builder(
                              controller: _pageController,
                              itemCount: widget.item.images.length,
                              onPageChanged: (int index) {
                                setState(() {
                                  _currentPage = index;
                                });
                              },
                              itemBuilder: (BuildContext context, int index) {
                                return Image.network(
                                  widget.item.images[index],
                                  fit: BoxFit.cover,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.05,
                              child: Row(
                                // crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "RM${itemController.calcDiscount(widget.item.price, widget.item.discountPercentage)}",
                                    style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.07,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5.0,
                                  ),
                                  Text(
                                    "RM${widget.item.price.toString()}",
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.045,
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.lineThrough,
                                        decorationColor: Colors.grey),
                                  ),
                                  const SizedBox(width: 5.0),
                                  Container(
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(5),
                                      ),
                                      color: Colors.yellow,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 2),
                                      child: Text(
                                        "-${widget.item.discountPercentage.round().toString()}%",
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.045,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              widget.item.title,
                              style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.height *
                                      0.02),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    size: 15,
                                    color: Colors.orange,
                                  ),
                                  Text(
                                    "${double.parse(widget.item.rating.toStringAsFixed(1)).toString()}/5",
                                    style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.02),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Description',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 10.0),
                            Text(widget.item.description),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        side: MaterialStateProperty.all(
                            const BorderSide(color: Colors.red)),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white),
                        shape: MaterialStateProperty.all(
                          const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(0)),
                          ),
                        ),
                      ),
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  topRight: Radius.circular(5),
                                ),
                                color: Colors.white,
                              ),
                              height: 200,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.2,
                                          child: Flex(
                                              direction: Axis.horizontal,
                                              children: [
                                                Expanded(
                                                  child: Image.network(
                                                      widget.item.thumbnail),
                                                ),
                                              ]),
                                        ),
                                        const SizedBox(width: 20),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.7,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                widget.item.title,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.05),
                                              ),
                                              const SizedBox(height: 20),
                                              MyBottomSheetContent(
                                                onCounterChanged:
                                                    _handleCounterChanged,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      child: ElevatedButton(
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.red),
                                          shape: MaterialStateProperty.all(
                                            const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(0)),
                                            ),
                                          ),
                                        ),
                                        onPressed: () async {
                                          print(widget.item.brand);
                                          final CartSharedPref shoppingCart =
                                              CartSharedPref();
                                          await shoppingCart.init('123');
                                          await shoppingCart.addToCart(
                                              '123',
                                              Cart(
                                                  quantity: _counter,
                                                  user: widget.userId,
                                                  items: widget.item));
                                          print('added to cart');
                                          Navigator.pop(context);
                                        },
                                        child: const Text(
                                          'Add to cart',
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 223, 220, 220)),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                        print('add to cart');
                      },
                      child: const Text(
                        'Add to cart',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.red),
                        shape: MaterialStateProperty.all(
                          const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(0)),
                          ),
                        ),
                      ),
                      onPressed: () {
                        print('buy now');
                      },
                      child: const Text(
                        'Checkout',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
