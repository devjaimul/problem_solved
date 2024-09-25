import 'package:flutter/material.dart';
import 'package:polynotepad/local_db/db_helper.dart';
class EditScreen extends StatefulWidget {
  const EditScreen({super.key});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {


  final titleEditController =  TextEditingController();
  final descriptionEditController =  TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  void _onTapAddProductButton() {
    if (_formKey.currentState!.validate()) {
      addNewProduct();
    }
  }

  Future<void> addNewProduct() async {
    // Save the product after validation
    if (titleEditController.text.isNotEmpty && descriptionEditController.text.isNotEmpty) {
      await DbHelper().addlist(context, titleEditController.text, descriptionEditController.text);
    } else {
      var snackBar = SnackBar(content: Text('All fields are required!'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit note",style: TextStyle(
            color: Colors.black
        )),
        centerTitle: true,
      ),
      body:SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: TextFormField(
                    controller: titleEditController,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.title),
                      hintText: 'Enter your title here',
                    ),
                    validator: (String? value){
                      if(value==null|| value.isEmpty){
                        return'Enter a valid Name';
                      }
                      return null;
                    },
                    textAlignVertical: TextAlignVertical.top,
                    textAlign: TextAlign.start,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: TextFormField(
                    validator: (String? value){
                      if(value==null|| value.isEmpty){
                        return'Enter a valid Name';
                      }
                      return null;
                    },
                    controller: descriptionEditController,
                    textAlignVertical: TextAlignVertical.top,
                    textAlign: TextAlign.start,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.title),
                      hintText: 'Enter description here',
                    ),
                    maxLines: 5,
                    onSaved: (String? value) {

                    },
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                    width: MediaQuery.sizeOf(context).width,
                    child: ElevatedButton(onPressed: _onTapAddProductButton, child:  Text("Save"),))

                // async{
                //   if(titleEditController.text.isEmpty || descriptionEditController.text.isEmpty){
                //     var snackBar = SnackBar(content: Text('All field are required !'));
                //     ScaffoldMessenger.of(context).showSnackBar(snackBar);
                //   }else{
                //     await DbHelper().addlist(context, titleEditController.text, descriptionEditController.text);
                //   }
                // }, child: Text("Save"),),),

              ],
            ),
          ),

        ),
      ),
    );

  }

}
