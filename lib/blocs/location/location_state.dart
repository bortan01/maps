part of 'location_bloc.dart';

 class LocationState extends Equatable {
  final bool followingUser;
  final LatLng? lastKnowLocation;
  final List<LatLng> myLocationHistory;
  
  const LocationState({
    this.followingUser = false,
    this.lastKnowLocation,
    myLocationHistory,
  }) : myLocationHistory = myLocationHistory ?? const [];

  @override
  List<Object?> get props => [followingUser, lastKnowLocation, myLocationHistory];

  LocationState copyWith({
    bool? followingUser,
    LatLng? lastKnowLocation,
    List<LatLng>? myLocationHistory,
  }) {
    return LocationState(
      followingUser: followingUser ?? this.followingUser,
      lastKnowLocation: lastKnowLocation ?? this.lastKnowLocation,
      myLocationHistory: myLocationHistory ?? this.myLocationHistory,
    );
  }
}

class LocationInitial extends LocationState {}
