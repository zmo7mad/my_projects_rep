import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
enum 
SeatState{  
  occupied ,
   available ,
    selected , }
class Seat {
  SeatState state;
  Seat(this.state);
  
}
 List<Movie> movies = [

  Movie(
    title: 'avengers' ,
    price: 12,
    seats: List.generate(64, (_) => Seat(SeatState.available)),
  ),
  Movie(
    title: 'titanic',
    price: 14,
    seats: List.generate(64, (_) => Seat(SeatState.available)),   
    ),
    Movie(
      title:'intersteller',
      price:10,
      seats: List.generate(64, (_) => Seat(SeatState.available)),   
      )
 ];

class Movie {
  final String title;
  final List<Seat> seats;
  final int price;

  Movie({required this.title, required this.seats , required this.price});
}

class SeatBookingState {
 final Movie? selectedMovie;
 List<Seat> seats;

  SeatBookingState({
  this.selectedMovie,
  required this.seats,
});

factory SeatBookingState.initial() {
  return SeatBookingState(seats: List.generate(64, (_)=> Seat(SeatState.available)),
  );
}
factory SeatBookingState.withMovie(Movie movie){
  return SeatBookingState(
    selectedMovie: movie,
    seats: movie.seats.isNotEmpty
    ? movie.seats
    : List.generate(64, (_)=> Seat(SeatState.available))
  );
}
SeatBookingState copyWith({
  Movie? selectedMovie , 
  List<Seat>? seats,
}){
  return SeatBookingState(
    selectedMovie : selectedMovie ?? this.selectedMovie,
    seats : seats?? this.seats,
  );
}
int get selectedSeatCount {
  return seats.where((seat) =>seat.state == SeatState.selected).length;
}
double get totalPrice {
  final price = selectedMovie?.price ?? 100;
  return selectedSeatCount* price.toDouble();
 }
}
final seatStateProvider = NotifierProvider<SeatStateNotifier, SeatBookingState>(
  () => SeatStateNotifier(),
);
class SeatStateNotifier extends Notifier<SeatBookingState> 
{
 @override
  SeatBookingState build() {
    return SeatBookingState.withMovie(movies[0]);
  }
  void toggleSeatSelection(int index) {
    final Updatedseats= List<Seat>.from(state.seats);
    if (Updatedseats[index].state == SeatState.available) {
      Updatedseats[index].state = SeatState.selected;
    }else if (Updatedseats[index].state == SeatState.selected)
    {
      Updatedseats[index].state = SeatState.available;
    }
    state = state.copyWith(seats:Updatedseats);
    }
    void selectedMovie(Movie movie)
    {
      state = SeatBookingState.withMovie(movie);
    }

  int get selectedSeatCount {
return state.seats.where((seat) => seat.state == SeatState.selected).length;  }
  double get totalPrice {
    final price = state.selectedMovie?.price??100 ;
    return selectedSeatCount * price.toDouble();
  }

}