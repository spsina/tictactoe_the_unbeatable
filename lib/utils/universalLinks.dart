import 'package:tictactoe/pages/battleSelect/joinGame.dart';
import 'package:tictactoe/utils/helper.dart';
import 'package:uni_links/uni_links.dart';

class UniversalLinks {

  UniversalLinks() {
    initUniLinks();
  }

  // set up the universal links listener
  Future<Null> initUniLinks() async {
    try {
      getLinksStream().listen(parseLink, onError: (err) {});
      parseLink(await getInitialLink());
    } catch (err) {}

  }

  // parse incoming links
  void parseLink(String link) async {
    try {
      if (link != null) {
        Uri uri = Uri.parse(link);
        String gameId = uri.queryParameters['gameId'];
        navigate(JoinGame(initialGameId: gameId), false);
      } else {}

    } catch(err) {}
  }
}