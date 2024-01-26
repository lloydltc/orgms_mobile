import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organisation_management/models/contribution.dart';


class ContributionCubit extends Cubit<Contribution>{

  ContributionCubit(Contribution state) : super(state);

  void contribute(Contribution contribution) => emit(contribution);

  void contributions(Contribution contribution) => emit(contribution);



}