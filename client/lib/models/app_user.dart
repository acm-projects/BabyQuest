// to access the current AppUser in any file downstream from `wrapper`, insert the following line of code:
// final appUser = Provider.of<AppUser?>(context);

class AppUser {
  final String uid;

  AppUser(this.uid);
}