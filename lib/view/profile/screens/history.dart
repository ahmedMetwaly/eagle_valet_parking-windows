import "package:flutter/material.dart";

class History extends StatelessWidget {
  const History({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("History")),
    ); /* Scaffold(
        appBar: AppBar(
            title: Text(S.current.history,
                style: Theme.of(context).textTheme.headlineMedium)),
        body: Padding(
          padding: const EdgeInsets.all(PaddingManager.pMainPadding),
          child: BlocBuilder<FirestoreBloc, FirestoreState>(
            builder: (context, state) {
              if (state is UpdatindDataState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return AuthenticationBloc.user.history!.isEmpty
                  ? Center(
                      child: Text(S.current.noHistory),
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              AuthenticationBloc.user.history = [];
                              context
                                  .read<FirestoreBloc>()
                                  .add(UserUpdateDataEvent());
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.delete,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .inversePrimary,
                                ),
                                const  SizedBox(width:SizeManager.sSpace),
                                Text(
                                  S.current.clear,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .background),
                                ),
                              ],
                            )),
                        const SizedBox(
                          height: SizeManager.sSpace,
                        ),
                        Expanded(
                          child: ListView.separated(
                              key: UniqueKey(),
                              itemBuilder: (context, index) => Dismissible(
                                    key: Key(index.toString()),
                                    background: Container(
                                      width: double.infinity,
                                      height: double.infinity,
                                      padding: const EdgeInsets.all(
                                          PaddingManager.pInternalPadding),
                                      decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          borderRadius: BorderRadius.circular(
                                              SizeManager
                                                  .borderRadiusOfInputField)),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            S.current.delete,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .background),
                                          ),
                                          const SizedBox(
                                            width: SizeManager.sSpace,
                                          ),
                                          Icon(
                                            Icons.delete,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .background,
                                          )
                                        ],
                                      ),
                                    ),
                                    direction: DismissDirection.endToStart,
                                    confirmDismiss: (direction) {
                                      return showDialog<bool>(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title:
                                                Text(S.current.confirmDelete),
                                            content:
                                                Text(S.current.deleteContent),
                                            actions: [
                                              TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(
                                                          context, true),
                                                  child: Text(S.current.ok)),
                                              TextButton(
                                                onPressed: () => Navigator.pop(
                                                    context, false),
                                                child: Text(S.current.cancel),
                                              )
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    onDismissed: (direction) {
                                      AuthenticationBloc.user.history
                                          ?.removeAt(index);
                                      context
                                          .read<FirestoreBloc>()
                                          .add(UserUpdateDataEvent());
                                    },
                                    child: Article(
                                      articleModel: AuthenticationBloc
                                          .user.history![index],
                                    ),
                                  ),
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                    height: SizeManager.sSpace,
                                  ),
                              itemCount:
                                  AuthenticationBloc.user.history!.length),
                        ),
                      ],
                    );
            },
          ),
        ));
   */
  }
}
