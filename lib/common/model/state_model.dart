abstract class BaseState{}

class LoadingState extends BaseState{}

class ErrorState extends BaseState{
  final String msg;

  ErrorState({
    required this.msg
  });
}
