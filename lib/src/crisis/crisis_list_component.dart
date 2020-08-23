import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';

import 'crisis.dart';
import 'crisis_service.dart';
import 'route_paths.dart';
import 'routes.dart';

@Component(
  selector: 'my-crises',
  providers: [ClassProvider(CrisisService)],
  templateUrl: 'crisis_list_component.html',
  styleUrls: ['crisis_list_component.css'],
  directives: [coreDirectives, RouterOutlet],
  exports: [RoutePaths, Routes],
)
class CrisisListComponent implements OnActivate {
  final CrisisService _crisisService;

  final Router _router;

  CrisisListComponent(this._crisisService, this._router);

  final title = 'Tour of Crises';

  List<Crisis> crises;

  Future<void> _getCrises() async {
    crises = await _crisisService.getAllSlowly();
  }

  @override
  void onActivate(RouterState previous, RouterState current) async {
    await _getCrises();
    selected = _select(current);
  }

  Crisis selected;

  Crisis _select(RouterState routerState) {
    final id = getId(routerState.parameters);
    return id == null
        ? null
        : crises.firstWhere((e) => e.id == id, orElse: () => null);
  }

  void onSelect(Crisis crisis) => _gotoDetail(crisis.id);

  String _crisisUrl(int id) =>
      RoutePaths.crisis.toUrl(parameters: {idParam: '$id'});

  Future<NavigationResult> _gotoDetail(int id) =>
      _router.navigate(_crisisUrl(id));
}
