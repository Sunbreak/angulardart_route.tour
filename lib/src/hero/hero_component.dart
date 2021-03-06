import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';

import '../route_paths.dart';
import 'hero.dart';
import 'hero_service.dart';

@Component(
  selector: 'my-hero',
  templateUrl: 'hero_component.html',
  styleUrls: ['hero_component.css'],
  directives: [coreDirectives, formDirectives],
)
class HeroComponent implements OnActivate {
  final HeroService _heroService;

  final Router _router;

  HeroComponent(this._heroService, this._router);

  Hero hero;

  @override
  void onActivate(RouterState previous, RouterState current) async {
    final id = getId(current.parameters);
    if (id != null) hero = await (_heroService.get(id));
  }

  void goBack() =>
      _router.navigate(
        RoutePaths.heroes.toUrl(),
        NavigationParams(queryParameters: {idParam: '${hero.id}'}),
      );
}
