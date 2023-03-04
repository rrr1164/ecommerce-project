import 'package:ecommerc/features/main/cubit/products/products_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/models/product.dart';

class SingleProduct extends StatefulWidget {
  const SingleProduct({Key? key, required this.product}) : super(key: key);
  final Product product;

  @override
  State<SingleProduct> createState() => _SingleProductState();
}

class _SingleProductState extends State<SingleProduct> {
  bool added = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      added = await BlocProvider.of<ProductsCubit>(context)
          .repo
          .isProductInCart(widget.product);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15), // Image border
                child: SizedBox.fromSize(
                  size: const Size.fromRadius(80), // Image radius
                  child: Image.network(widget.product.thumbnail,
                      fit: BoxFit.cover),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text(
                  widget.product.title,
                  style: const TextStyle(
                      overflow: TextOverflow.ellipsis, fontSize: 18),
                  maxLines: 1,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text(
                  '\$${widget.product.price}',
                  style: const TextStyle(
                      overflow: TextOverflow.ellipsis,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                  maxLines: 1,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ElevatedButton(
                      onPressed: () {
                        if (!added) {
                          BlocProvider.of<ProductsCubit>(context)
                              .repo
                              .addProductToCart(widget.product);
                          setState(() {
                            added = true;
                          });
                        } else {}
                      },
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                   RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          )),
                          backgroundColor: added
                              ? MaterialStateProperty.all(Colors.orange)
                              : MaterialStateProperty.all(Colors.black)),
                      child: Text(
                        added ? "Added To Cart" : "Add To Cart",
                        maxLines: 1,
                        style: const TextStyle(overflow: TextOverflow.ellipsis),
                      ),
                    ),
                  )),
              const SizedBox(
                height: 5,
              ),
            ],
          ),
        ));
  }
}
