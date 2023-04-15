class CastLike {
  // function cast
  static cast(int nbr) {
    String like = nbr.toString();
    if (like.length >= 4 && like.length < 7) {
      return like.replaceRange(like.length - 3, like.length, "k");
    }
    if (like.length >= 7) {
      return like.replaceRange(like.length - 6, like.length, "M");
    } else {
      return nbr.toString();
    }
  }
}
