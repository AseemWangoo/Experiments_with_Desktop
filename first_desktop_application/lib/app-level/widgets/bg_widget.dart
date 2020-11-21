import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

import 'package:init_dsktp_plugin/init_dsktp_plugin.dart';

class BgWidget extends StatelessWidget {
  const BgWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //

    return Stack(
      alignment: AlignmentDirectional.center,
      children: <Widget>[
        const FlareActor(
          'assets/animations/spaceman.flr',
          alignment: Alignment.centerLeft,
          fit: BoxFit.cover,
          animation: 'Untitled',
        ),
        Positioned(
          bottom: 10.0,
          child: FutureBuilder<String>(
            future: InitDsktpPlugin.platformVersion,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return _CustomText(data: snapshot.data);
              }

              return const Text('');
            },
          ),
        ),
      ],
    );
  }
}

class _CustomText extends StatelessWidget {
  const _CustomText({Key key, this.data}) : super(key: key);

  final String data;

  @override
  Widget build(BuildContext context) {
    //

    return Text(
      data,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 24.0,
      ),
    );
  }
}
