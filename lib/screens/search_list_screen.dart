import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gpt/components/card_component.dart';
import 'package:gpt/utils/app_colors.dart';
import 'package:gpt/utils/typography.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../blocs/recherche/recherche_bloc.dart';

class SearchListScreen extends StatelessWidget {
  final String date1;
  final String date2;
  final String? numCompte;
  final String idUser;

  const SearchListScreen(
      {super.key,
      required this.date1,
      required this.date2,
      required this.numCompte, required this.idUser});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RechercheBloc()
        ..add(numCompte != null
            ? RecherchePrecisionEvent(
                date1: date1, date2: date2, numCompte: numCompte!, idUser: idUser)
            : RechercheSansPrecisionEvent(date1: date1, date2: date2, idUser: idUser)),
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: AppColors.colorTextInput,
          backgroundColor: AppColors.background,
          title: TypoText(
                  text: AppLocalizations.of(context)!.search,
                  color: AppColors.colorTextInput)
              .large(),
        ),
        body: BlocBuilder<RechercheBloc, RechercheState>(
          builder: (context, state) {
            if (state is RecherchePrecisionWaitingState) {
              return Center(
                child: CircularProgressIndicator(
                    color: AppColors.backgroundButton),
              );
            }

            if (state is RechercheSuccessState) {
              return state.cotisationModel.isEmpty
                  ? Center(
                      child: TypoText(text: AppLocalizations.of(context)!.not_found_cotisation, color: AppColors.colorTextInput).longCast(),
                    )
                  : ListView.builder(
                      itemCount: state.cotisationModel.length,
                      itemBuilder: (context, index) {
                        return CardComponent(
                            cotisationModel: state.cotisationModel[index]);
                      });
            }
            return Container();
          },
        ),
      ),
    );
  }
}
