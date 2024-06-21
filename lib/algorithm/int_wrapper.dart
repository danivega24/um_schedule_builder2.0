//just to pass int by reference
class Int_wrapper{
  int val; //int_val
  Int_wrapper(this.val); //constructor
  void add_to_val(int addition){ //adding to the val
    val += addition;
  }
}