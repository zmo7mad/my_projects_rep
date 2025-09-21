import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movieseatbookingapp/state_provider.dart';

class Seatbooking extends ConsumerWidget {
  const Seatbooking({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final seatBookingState = ref.watch(seatStateProvider);
    final seats = seatBookingState.seats;
    
    return Scaffold(
      
      backgroundColor: const Color.fromARGB(255, 43, 43, 77),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 80),
            const Text(
              "Seat Booking App",
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          
            Container(
              margin: const EdgeInsets.symmetric(vertical: 30),
              width: 300,
              height: 50,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 43, 46, 92),
                borderRadius: BorderRadius.circular(20),
              ),
                
            child: DropdownButton<Movie>(
              isExpanded: true,
              value: seatBookingState.selectedMovie,
              dropdownColor: Colors.indigoAccent,
              underline: const SizedBox(height: 2,),
              items : movies.map((movie){
                return DropdownMenuItem<Movie>(
                  value: movie,
                  child: Center(
                  child: Text(movie.title,
                  textAlign: TextAlign.center,),)
                  );
              }).toList(),
              onChanged:(movie) {
                if (movie != null)
                {
                  ref.read(seatStateProvider.notifier).selectedMovie(movie);
                }
              },
            ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 15),
              decoration: 
              BoxDecoration(
               borderRadius: BorderRadius.circular(11),
               color: const Color.fromARGB(255, 79, 67, 146)
              ),

              
              padding: EdgeInsets.all(14),
              child: 
              Text('the total price is : ${seatBookingState.totalPrice}',
              ),

            ),
            Container(
              color: const Color.fromARGB(179, 146, 146, 146),
               width: 333,
               height: 49,
                child: const Center(
                 child: Text(
                  "Screen",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  
                ),
              ),
           
            ),
            const SizedBox(height: 20,),    
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 13,
                  crossAxisSpacing: 22,
                ),
                itemCount: seats.length,
                itemBuilder: (context, index) {
                  final seat = seats[index];
                  return GestureDetector(
                    onTap: () {
                      ref.read(seatStateProvider.notifier).toggleSeatSelection(index);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: _getSeatColor(seat.state), 
                        borderRadius: BorderRadius.circular(5),
                      ),
                     
                      
                    ),
                  );
                },
              ),
              
            ),
          const SizedBox(height : 44)

          ],

        ),

      ),

    )
;
  }
}

Color _getSeatColor(SeatState state) {
  switch (state) {
    case SeatState.available:
      return const Color.fromARGB(255, 253, 253, 253);
    case SeatState.selected:
      return const Color.fromARGB(255, 82, 145, 197);
    case SeatState.occupied:
      return const Color.fromARGB(255, 85, 85, 85);
    default:
      return Colors.grey;
  }
}