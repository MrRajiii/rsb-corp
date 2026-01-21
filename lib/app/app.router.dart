// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedNavigatorGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/material.dart' as _i11;
import 'package:flutter/material.dart';
import 'package:rsbweb_v1/ui/views/bungalow/bungalow_view.dart' as _i4;
import 'package:rsbweb_v1/ui/views/company_profile/company_profile_view.dart'
    as _i10;
import 'package:rsbweb_v1/ui/views/constructionworks/constructionworks_view.dart'
    as _i6;
import 'package:rsbweb_v1/ui/views/finishedprojects/finishedprojects_view.dart'
    as _i8;
import 'package:rsbweb_v1/ui/views/home/home_view.dart' as _i2;
import 'package:rsbweb_v1/ui/views/interiordesign/interiordesign_view.dart'
    as _i7;
import 'package:rsbweb_v1/ui/views/project_detail/project_detail_view.dart'
    as _i9;
import 'package:rsbweb_v1/ui/views/startup/startup_view.dart' as _i3;
import 'package:rsbweb_v1/ui/views/two_storey/two_storey_view.dart' as _i5;
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i12;

class Routes {
  static const homeView = '/home-view';

  static const startupView = '/startup-view';

  static const bungalowView = '/bungalow-view';

  static const twoStoreyView = '/two-storey-view';

  static const constructionWorksView = '/construction-works-view';

  static const interiorDesignView = '/interior-design-view';

  static const finishedProjectsView = '/finished-projects-view';

  static const projectDetailView = '/project-detail-view';

  static const companyProfileView = '/company-profile-view';

  static const all = <String>{
    homeView,
    startupView,
    bungalowView,
    twoStoreyView,
    constructionWorksView,
    interiorDesignView,
    finishedProjectsView,
    projectDetailView,
    companyProfileView,
  };
}

class StackedRouter extends _i1.RouterBase {
  final _routes = <_i1.RouteDef>[
    _i1.RouteDef(
      Routes.homeView,
      page: _i2.HomeView,
    ),
    _i1.RouteDef(
      Routes.startupView,
      page: _i3.StartupView,
    ),
    _i1.RouteDef(
      Routes.bungalowView,
      page: _i4.BungalowView,
    ),
    _i1.RouteDef(
      Routes.twoStoreyView,
      page: _i5.TwoStoreyView,
    ),
    _i1.RouteDef(
      Routes.constructionWorksView,
      page: _i6.ConstructionWorksView,
    ),
    _i1.RouteDef(
      Routes.interiorDesignView,
      page: _i7.InteriorDesignView,
    ),
    _i1.RouteDef(
      Routes.finishedProjectsView,
      page: _i8.FinishedProjectsView,
    ),
    _i1.RouteDef(
      Routes.projectDetailView,
      page: _i9.ProjectDetailView,
    ),
    _i1.RouteDef(
      Routes.companyProfileView,
      page: _i10.CompanyProfileView,
    ),
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.HomeView: (data) {
      return _i11.MaterialPageRoute<dynamic>(
        builder: (context) => const _i2.HomeView(),
        settings: data,
      );
    },
    _i3.StartupView: (data) {
      return _i11.MaterialPageRoute<dynamic>(
        builder: (context) => const _i3.StartupView(),
        settings: data,
      );
    },
    _i4.BungalowView: (data) {
      return _i11.MaterialPageRoute<dynamic>(
        builder: (context) => const _i4.BungalowView(),
        settings: data,
      );
    },
    _i5.TwoStoreyView: (data) {
      return _i11.MaterialPageRoute<dynamic>(
        builder: (context) => const _i5.TwoStoreyView(),
        settings: data,
      );
    },
    _i6.ConstructionWorksView: (data) {
      return _i11.MaterialPageRoute<dynamic>(
        builder: (context) => const _i6.ConstructionWorksView(),
        settings: data,
      );
    },
    _i7.InteriorDesignView: (data) {
      return _i11.MaterialPageRoute<dynamic>(
        builder: (context) => const _i7.InteriorDesignView(),
        settings: data,
      );
    },
    _i8.FinishedProjectsView: (data) {
      return _i11.MaterialPageRoute<dynamic>(
        builder: (context) => const _i8.FinishedProjectsView(),
        settings: data,
      );
    },
    _i9.ProjectDetailView: (data) {
      final args = data.getArgs<ProjectDetailViewArguments>(nullOk: false);
      return _i11.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i9.ProjectDetailView(key: args.key, project: args.project),
        settings: data,
      );
    },
    _i10.CompanyProfileView: (data) {
      return _i11.MaterialPageRoute<dynamic>(
        builder: (context) => const _i10.CompanyProfileView(),
        settings: data,
      );
    },
  };

  @override
  List<_i1.RouteDef> get routes => _routes;

  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
}

class ProjectDetailViewArguments {
  const ProjectDetailViewArguments({
    this.key,
    required this.project,
  });

  final _i11.Key? key;

  final Map<String, dynamic> project;

  @override
  String toString() {
    return '{"key": "$key", "project": "$project"}';
  }

  @override
  bool operator ==(covariant ProjectDetailViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.project == project;
  }

  @override
  int get hashCode {
    return key.hashCode ^ project.hashCode;
  }
}

extension NavigatorStateExtension on _i12.NavigationService {
  Future<dynamic> navigateToHomeView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.homeView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToStartupView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.startupView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToBungalowView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.bungalowView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToTwoStoreyView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.twoStoreyView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToConstructionWorksView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.constructionWorksView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToInteriorDesignView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.interiorDesignView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToFinishedProjectsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.finishedProjectsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToProjectDetailView({
    _i11.Key? key,
    required Map<String, dynamic> project,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.projectDetailView,
        arguments: ProjectDetailViewArguments(key: key, project: project),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToCompanyProfileView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.companyProfileView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithHomeView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.homeView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithStartupView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.startupView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithBungalowView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.bungalowView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithTwoStoreyView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.twoStoreyView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithConstructionWorksView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.constructionWorksView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithInteriorDesignView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.interiorDesignView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithFinishedProjectsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.finishedProjectsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithProjectDetailView({
    _i11.Key? key,
    required Map<String, dynamic> project,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.projectDetailView,
        arguments: ProjectDetailViewArguments(key: key, project: project),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithCompanyProfileView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.companyProfileView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }
}
