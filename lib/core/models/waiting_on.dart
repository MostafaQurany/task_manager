enum WaitingOn { none, client, team }

extension WaitingOnExtension on WaitingOn {
  String get label {
    switch (this) {
      case WaitingOn.client:
        return 'Waiting on Client';
      case WaitingOn.team:
        return 'Waiting on Team';
      case WaitingOn.none:
        return '';
    }
  }

  bool get isWaiting => this != WaitingOn.none;
}
