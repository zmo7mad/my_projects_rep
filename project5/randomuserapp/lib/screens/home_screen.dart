import 'package:flutter/material.dart';
import 'package:randomuserapp/models/user_model.dart';
import 'package:randomuserapp/services/user_service.dart';
import 'package:randomuserapp/utils/formatters.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
    
  List<UserModel> allUsers = [];
  List<UserModel> displayedUsers = [];
  bool showingMilionairesOnly = false;
  bool isLoading = false;
  bool sortedByWealth = false;
   Future <void> addnewuser() async {
    setState(() {
      isLoading = true;
    });
   final user = await UserService().fetchRandomUser();
     if (user != null)
     {
      setState(() {
        allUsers.add(user);
        _updateDisplayedUsers();
        isLoading = false;
      });
     } else{
    setState(() {
      isLoading = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('failed to fetch user'))
    );
     }
   
  }
  void toggleMilionairesFilter() {
   setState(() {
     showingMilionairesOnly = !showingMilionairesOnly;
     _updateDisplayedUsers();
   });
  }
  void _updateDisplayedUsers() {
    List<UserModel> usersToShow;
    if (showingMilionairesOnly){
      usersToShow = allUsers.where((user) => user.wealth >= 1000000).toList();
    }else{
      usersToShow = List.from(allUsers);
    }
    if(sortedByWealth)
    {
      usersToShow.sort((a , b)=>b.wealth.compareTo(a.wealth));
    }
    displayedUsers = usersToShow;
  }
void sortByWealth() {
    print('Sort button pressed!');

    setState(() {
      sortedByWealth = true;
          print('sortedByWealth is now: $sortedByWealth');
      _updateDisplayedUsers();
          print('displayedUsers length: ${displayedUsers.length}');

    });
}
void doubleAllWealth() {
  setState(() {
    for (int i = 0; i < allUsers.length; i ++)
    {
      final user = allUsers[i];
      allUsers[i] = UserModel(
        firstName: user.firstName,
         lastName: user.lastName, 
         title: user.title, 
         wealth: user.wealth * 2,
         );
    }
    _updateDisplayedUsers();
  });
}
int calculateTotalWealth() {
  if(allUsers.isEmpty){
    return 0;
  }
  return allUsers.map((user) => user.wealth).reduce((a,b)=>a+b);
}

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: 
        Text('wealthest people on earth' ,
        style: TextStyle(
        fontSize: 22,
        ),),
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        children: [
         const SizedBox(height: 22),
          Text('total Wealth:'  + Formatters.formatCurrency(calculateTotalWealth())),
          const SizedBox(height: 22),
          Column(
            children: [
              ElevatedButton(
                onPressed: addnewuser,
                 child: Text('add a person' )
              ),
              const SizedBox(height :7),
              ElevatedButton(onPressed: doubleAllWealth, 
              child: Text('double the wealth of those fine gentelmen/ladies')),
              const SizedBox(height :7),
              ElevatedButton(onPressed: sortByWealth, 
              child: Text('sort them by the wealthest')),
              const SizedBox(height :7),
              ElevatedButton(onPressed: toggleMilionairesFilter, 
              child: Text('SEE WHO ARE THE LUCKY MILIONARIES')),
              const SizedBox(height :7),
              ElevatedButton(onPressed: calculateTotalWealth, 
              child:Text('see the total amount of all the riches in the world'))
            ],


        ),
         Expanded(
          child:ListView.builder(
            itemCount: displayedUsers.length,
            itemBuilder: (context , index) {
              final user = displayedUsers[index];
              return ListTile(
                title: Text(user.firstName),
                minVerticalPadding: 22,
                subtitle: Text(Formatters.formatCurrency(user.wealth)),
              );
            }
        
            ) ,)
        ],
      ),
    );
  }
}