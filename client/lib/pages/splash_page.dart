class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(children: [
          Positioned(
              top: 80,
              left: xDefaultSize,
              child: Column(children: [
                Text(
                  xAppName,
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                Text(
                  xAppTagLine,
                  style: Theme.of(context).textTheme.headlineSmall,
                )
              ])),
          const Positioned(
              bottom: 100,
              child: Image(
                image: AssetImage(xSplashImage),
              )),
          Positioned(
              bottom: 40,
              right: xDefaultSize,
              child: Container(
                width: xSplashContainerSize,
                height: xSplashContainerSize,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: xPrimaryColor,
                ),
              ))
        ]),
      ),
    );
  }
}
