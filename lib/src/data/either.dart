class Either<T1, T2> {
  final T1? t1;
  final T2? t2;

  final bool isT1;
  final bool isT2;

  Either({
    this.t1,
    this.t2,
  })  : isT1 = t1 != null,
        isT2 = t2 != null;
}
