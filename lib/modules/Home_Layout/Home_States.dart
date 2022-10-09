abstract class HomeStates {}

class InitialState extends HomeStates {}

class GetUserSuccessState extends HomeStates {}

class GetUserLoadingState extends HomeStates {}

class GetUserErrorState extends HomeStates {}

class BottomNavChangeState extends HomeStates {}

class BottomAddPostState extends HomeStates {}

class GetProfileImageSuccessState extends HomeStates {}

class GetProfileImageErrorState extends HomeStates {}

class GetUploadProfileImageSuccessState extends HomeStates {}

class GetUploadProfileImageErrorState extends HomeStates {}

class GetCoverImageSuccessState extends HomeStates {}

class GetCoverImageErrorState extends HomeStates {}

class GetCoverUploadImageSuccessState extends HomeStates {}

class GetCoverUploadImageErrorState extends HomeStates {}

class UpdateUserErrorState extends HomeStates {}

class UpdateUserLoadingState extends HomeStates {}


//Posts

class GetPostImageSuccessState extends HomeStates {}

class GetPostImageErrorState extends HomeStates {}


class CreatePostSuccessState extends HomeStates {}

class CreatePostLoadingState extends HomeStates {}

class CreatePostErrorState extends HomeStates {}

class RemovePostImageState extends HomeStates {}

// get posts


class GetPostsSuccessState extends HomeStates {}

class GetPostsLoadingState extends HomeStates {}

class GetPostsErrorState extends HomeStates {}

//likes

class PostLikeSuccessState extends HomeStates {}


class PostLikeErrorState extends HomeStates {}

// Chat users

class GetAllUserSuccessState extends HomeStates {}

class GetAllUserErrorState extends HomeStates {}


// chat messeges

class SendMessageSuccessState extends HomeStates {}

class SendMessageErrorState extends HomeStates {}

class SendMessageToFriendSuccessState extends HomeStates {}

class SendMessageToFriendErrorState extends HomeStates {}

class GetMessageSuccessState extends HomeStates {}
