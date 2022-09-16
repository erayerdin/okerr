// ignore_for_file: avoid_print

import 'package:okerr/okerr.dart';

enum VoterFailure { tooYoung, tooOld }

Result<bool, VoterFailure> canVote(int age) {
  if (age < 0) {
    return Err(VoterFailure.tooYoung);
  }

  if (age > 150) {
    return Err(VoterFailure.tooOld);
  }

  return Ok(age >= 18);
}

void main() {
  const burton = 10;
  const kendrick = 20;
  const shae = -1;
  const calvin = 200;

  final canBurtonVote = canVote(burton);
  final canKendrickVote = canVote(kendrick);
  final canShaeVote = canVote(shae);
  final canCalvinVote = canVote(calvin);

  print(canBurtonVote);
  print(canKendrickVote);
  print(canShaeVote);
  print(canCalvinVote);
}
