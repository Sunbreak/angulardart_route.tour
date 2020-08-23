import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';

import '../route_paths.dart';
import 'hero.dart';
import 'hero_service.dart';

@Component(
  selector: 'my-heroes',
  providers: [ClassProvider(HeroService)],
  templateUrl: 'hero_list_component.html',
  styleUrls: ['hero_list_component.css'],
  directives: [coreDirectives],
  pipes: [commonPipes],
)
class HeroListComponent implements OnActivate {
  final HeroService _heroService;

  final Router _router;

  HeroListComponent(this._heroService, this._router);

  final title = 'Tour of Heroes';

  List<Hero> heroes;

  Future<void> _getHeroes() async {
    heroes = await _heroService.getAllSlowly();
  }

  @override
  void onActivate(RouterState previous, RouterState current) async {
    await _getHeroes();
    selected = _select(current);
  }

  Hero selected;

  Hero _select(RouterState routerState) {
    final id = getId(routerState.queryParameters);
    return id == null
        ? null
        : heroes.firstWhere((e) => e.id == id, orElse: () => null);
  }

  void onSelect(Hero hero) => _gotoDetail(hero.id);

  String _heroUrl(int id) =>
      RoutePaths.hero.toUrl(parameters: {idParam: '$id'});

  Future<NavigationResult> _gotoDetail(int id) =>
      _router.navigate(_heroUrl(id));
}
