import 'package:flutter/material.dart';
import 'package:zawadi/presentation/splash/on_boarding/indie_3d_model_controller.dart';
import 'package:zawadi/presentation/splash/on_boarding/indie_app_bar.dart';
import 'package:zawadi/presentation/splash/on_boarding/navigation.dart';
import 'package:zawadi/presentation/splash/on_boarding/page.dart';
import 'package:zawadi/shared/app_assets/app_assets.dart';



class Indie3dHome extends StatefulWidget {
  const Indie3dHome({Key? key}) : super(key: key);

  @override
  State createState() => _Indie3dHomeState();
}

class _Indie3dHomeState extends State<Indie3dHome> with TickerProviderStateMixin {

  late AnimationController _page0TopTitleController;
  late AnimationController _page0BottomTitleController;
  late AnimationController _page1TopTitleController;
  late AnimationController _page1BottomTitleController;
  late AnimationController _page2TopTitleController;
  late AnimationController _page2BottomTitleController;
  late Indie3dModelController _controller;

  int _pageIndex = 0;

  @override
  void initState() {

    const duration = Duration(milliseconds: 400);

    _page0TopTitleController = AnimationController(vsync: this, duration: duration, value: 1.0);
    _page0BottomTitleController = AnimationController(vsync: this, duration: duration, value: 1.0);
    _page1TopTitleController = AnimationController(vsync: this, duration: duration, value: 0.0);
    _page1BottomTitleController = AnimationController(vsync: this, duration: duration, value: 0.0);
    _page2TopTitleController = AnimationController(vsync: this, duration: duration, value: 0.0);
    _page2BottomTitleController = AnimationController(vsync: this, duration: duration, value: 0.0);

    _controller = Indie3dModelController();

    Listenable.merge([
      _page0TopTitleController,
      _page0BottomTitleController,
      _page1TopTitleController,
      _page1BottomTitleController,
      _page2TopTitleController,
      _page2BottomTitleController,
      _controller,
    ]).addListener(() {
      setState(() {
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    _page0TopTitleController.dispose();
    _page0BottomTitleController.dispose();
    _page1TopTitleController.dispose();
    _page1BottomTitleController.dispose();
    _page2TopTitleController.dispose();
    _page2BottomTitleController.dispose();
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_controller.initialized) {
      precacheImage(const AssetImage(AppAssets.artist1,), context);
      precacheImage(const AssetImage(AppAssets.artist2,), context);
      precacheImage(const AssetImage(AppAssets.artist3, ), context);
      precacheImage(const AssetImage(AppAssets.noise, ), context);

      _controller.init(context);
    }
    _controller.setView(MediaQuery.of(context).size);
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            GestureDetector(
              onTapUp: _handleTap,
              child: _buildPages(),
            ),
            const IndieAppBar(),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                  padding: const EdgeInsets.only(bottom: 32),
                  child: Indie3dNavigationIndicator(pageIndex: _pageIndex,)),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildPages() {
    final result = NotificationListener<ScrollUpdateNotification>(
      onNotification: _handleScroll,
      child: PageView(
        physics: const BouncingScrollPhysics(),
        onPageChanged: _handlePageChange,
        children: [
          _buildPageForIndex(0),
          _buildPageForIndex(1),
          _buildPageForIndex(2),
        ],
      ),
    );
    return result;
  }

  Widget _buildPageForIndex(int index) {
    Widget? result;
    switch (index) {
      case 0:
        result = Indie3dPage(
          topTitle: 'MILES',
          bottomTitle: 'MILLER',
          backgroundColor:const Color(0xFF0DD479),
          image: const AssetImage(AppAssets.artist1, ),
          // pageIndex: 0,
          controller: _controller,
          topTitleClipProgress: 1.0 - _page0TopTitleController.value,
          bottomTitleClipProgress: 1.0 - _page0BottomTitleController.value,
          // bottomTitleScale: 1.0,
        );
        break;
      case 1:
        result = Indie3dPage(
          topTitle: 'BRET',
          bottomTitle: 'HAMPTON',
          backgroundColor: const Color(0xFFECA6C8),
          image: const AssetImage(AppAssets.artist2,),
          pageIndex: 1,
          controller: _controller,
          topTitleClipProgress: 1.0 - _page1TopTitleController.value,
          bottomTitleClipProgress: 1.0 - _page1BottomTitleController.value,
          backgroundShapeOpacity: 1,
          bottomTitleScale: 0.9,
        );
        break;
      case 2:
        result = Indie3dPage(
          topTitle: 'CINDY',
          bottomTitle: 'GREY',
          backgroundColor: const Color(0xFFFFD500),
          image: const AssetImage(AppAssets.artist3, ),
          pageIndex: 2,
          controller: _controller,
          topTitleClipProgress: 1.0 - _page2TopTitleController.value,
          bottomTitleClipProgress: 1.0 - _page2BottomTitleController.value,
        );
        break;
    }
    return result!;
  }

  bool _handleScroll(ScrollUpdateNotification? scrollUpdate) {
    setState(() {
      final appSize = MediaQuery.of(context).size;
      final  pageProgress = (1.0 - ((scrollUpdate!.metrics.pixels / appSize.width) - _pageIndex)
          .abs().clamp(0.0, 1.0)) * 2.0 - 1.0;
      _controller.cameraOffset = (1 - pageProgress) * 8.0 * scrollUpdate.scrollDelta!.sign;

      // ignore: omit_local_variable_types
      double animValue = 0;
      switch (_pageIndex) {
        case 0: animValue = _page0TopTitleController.value; break;
        case 1: animValue = _page1TopTitleController.value; break;
        case 2: animValue = _page2TopTitleController.value; break;
      }

      if (animValue != 0) {
        switch (_pageIndex) {
          case 0:
            if (!_page0TopTitleController.isAnimating) {
              _page0TopTitleController.value = pageProgress;
              _page0BottomTitleController.value = pageProgress;
            }
            break;
          case 1:
            if (!_page1TopTitleController.isAnimating) {
              _page1TopTitleController.value = pageProgress;
              _page1BottomTitleController.value = pageProgress;
            }
            break;
          case 2:
            if (!_page2TopTitleController.isAnimating) {
              _page2TopTitleController.value = pageProgress;
              _page2BottomTitleController.value = pageProgress;
            }
            break;
        }
      }
      switch (_pageIndex) {
        case 0:
          if (pageProgress > 0.99) {
            _page0TopTitleController.animateTo(1.0);
            Future.delayed(const Duration(milliseconds: 200),
              () => _page0BottomTitleController.animateTo(1)
            );
          }
          _page1TopTitleController.reset();
          _page1BottomTitleController.reset();
          _page2TopTitleController.reset();
          _page2BottomTitleController.reset();
          break;
        case 1:
          _page0TopTitleController.reset();
          _page0BottomTitleController.reset();
          if (pageProgress > 0.99) {
            _page1TopTitleController.animateTo(1.0);
            Future.delayed(const Duration(milliseconds: 200),
              () => _page1BottomTitleController.animateTo(1)
            );
          }
          _page2TopTitleController.reset();
          _page2BottomTitleController.reset();
          break;
        case 2:
          _page0TopTitleController.reset();
          _page0BottomTitleController.reset();
          _page1TopTitleController.reset();
          _page1BottomTitleController.reset();
          if (pageProgress > 0.99) {
            _page2TopTitleController.animateTo(1.0);
            Future.delayed(const Duration(milliseconds: 200),
              () => _page2BottomTitleController.animateTo(1)
            );
          }
          break;
      }
    });

    return false;
  }

  void _handleTap(TapUpDetails details) {
    _controller.triggerTap(context, details.localPosition, _pageIndex);
  }

  void _handlePageChange(int page) {
    setState(() {
      _pageIndex = page;
    });
  }

}



