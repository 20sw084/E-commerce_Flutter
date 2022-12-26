/*
* SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(children: [
                      const SizedBox(height: 24),
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                                onPressed: () => Navigator.pop(context),
                                icon: const Icon(Icons.arrow_back),
                                iconSize: 32),
                            const SizedBox(width: 32),
                            const Text('Edit Store Information',
                                style: TextStyle(
                                    fontSize: 28, fontWeight: FontWeight.w500)),
                          ]),
                      const SizedBox(height: 40),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Expanded(
                                child: Text('Store Name',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18))),
                            SizedBox(width: 18),
                            Expanded(
                                child: Text('Category',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18))),
                          ]),
                      const SizedBox(height: 16),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                                child: TextField(
                              decoration:
                                  textInputDecoration(label: 'Store Name'),
                              onChanged: (val) => name = val,
                            )),
                            const SizedBox(width: 18),
                            Expanded(
                                child: Container(
                                    padding: const EdgeInsets.only(
                                        right: 12, left: 16),
                                    decoration: BoxDecoration(
                                        color: const Color(0xffF0F0F0),
                                        borderRadius: BorderRadius.circular(12)),
                                    height: 50,
                                    alignment: Alignment.center,
                                    child: DropdownButton<String>(
                                      value: selectedCategory,
                                      onChanged: (value) => setState(() =>
                                          selectedCategory = value.toString()),
                                      iconEnabledColor: red,
                                      borderRadius: BorderRadius.circular(10),
                                      isExpanded: true,
                                      underline: const SizedBox.shrink(),
                                      style:
                                          TextStyle(color: Colors.grey.shade700),
                                      items: categories
                                          .map((val) => DropdownMenuItem<String>(
                                              value: val["name"] ?? "Waiting",
                                              child: Text(val["name"] ?? "")))
                                          .toList(),
                                    )))
                          ]),
                      const SizedBox(height: 40),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Expanded(
                                child: Text('Store Profile Image',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18))),
                            SizedBox(width: 18),
                            Expanded(
                                child: Text('Cover Image',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18))),
                          ]),
                      const SizedBox(height: 16),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // TODO apply upload picture functionality
                            uploadImageButton(),
                            const SizedBox(width: 18),
                            // TODO apply upload picture functionality
                            uploadImageButton()
                          ]),
                      const SizedBox(height: 16),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                                child: Row(children: [
                              Container(
                                  height: 120,
                                  width: 120,
                                  decoration: BoxDecoration(
                                      color: white,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                          color: Colors.grey.shade200, width: 4)),
                                  child: Stack(children: [
                                    Image.asset(
                                        '$imagePath/sample_store_image.png',
                                        fit: BoxFit.cover),
                                    Positioned(
                                        top: 6,
                                        right: 6,
                                        child: CircleAvatar(
                                            backgroundColor: red,
                                            radius: 12,
                                            child: Icon(Icons.close,
                                                size: 20, color: white)))
                                  ]))
                            ])),
                            const SizedBox(width: 12),
                            Expanded(
                                child: Container(
                                    height: 120,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        color: white,
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                            color: Colors.grey.shade200,
                                            width: 4)),
                                    child: Stack(children: [
                                      ClipRRect(
                                          borderRadius: BorderRadius.circular(4),
                                          child: Image.asset(
                                              '$imagePath/sample_store_cover.jpg',
                                              height: 120,
                                              width: double.infinity,
                                              fit: BoxFit.cover)),
                                      Positioned(
                                          top: 6,
                                          right: 6,
                                          child: CircleAvatar(
                                              backgroundColor: red,
                                              radius: 12,
                                              child: Icon(Icons.close,
                                                  size: 20, color: white)))
                                    ])))
                          ]),
                      const SizedBox(height: 40),
                      const Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Description',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 18))),
                      const SizedBox(height: 16),
                      TextField(
                          onChanged: (val) => description = val,
                          minLines: 1,
                          maxLines: 10,
                          decoration: InputDecoration(
                              fillColor: const Color(0xffF0F0F0),
                              focusColor: const Color(0xff9E9E9E),
                              filled: true,
                              hintStyle: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff808080)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 1, color: Color(0xffF0F0F0)),
                                  borderRadius: BorderRadius.circular(12)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 2, color: Color(0xff9E9E9E)),
                                  borderRadius: BorderRadius.circular(12)),
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 24),
                              hintText: 'Store description...')),
                      const SizedBox(
                        height: 20.0,
                      ),
                      const Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Category',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 18))),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                                onChanged: (val) => newCategoryName = val,
                                decoration: InputDecoration(
                                    fillColor: const Color(0xffF0F0F0),
                                    focusColor: const Color(0xff9E9E9E),
                                    filled: true,
                                    hintStyle: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xff808080)),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            width: 1, color: Color(0xffF0F0F0)),
                                        borderRadius: BorderRadius.circular(12)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            width: 2, color: Color(0xff9E9E9E)),
                                        borderRadius: BorderRadius.circular(12)),
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 24),
                                    hintText: 'Store category...')),
                          ),
                          const SizedBox(
                            width: 20.0,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: TextButton(
                              onPressed: () async {
                                dynamic response = await createCategory(
                                    token: globals.token, name: newCategoryName);
                                if (response != null) {
                                  final snackBar = SnackBar(
                                    /// need to set following properties for best effect of awesome_snackbar_content
                                    elevation: 0,
                                    /*duration: const Duration(
                                      milliseconds: 3000),*/
                                    behavior: SnackBarBehavior.floating,
                                    backgroundColor: Colors.transparent,
                                    content: AwesomeSnackbarContent(
                                      title: 'Success!',
                                      message: response,

                                      /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                                      contentType: ContentType.success,
                                    ),
                                  );
                                  if (!mounted) return;
                                  ScaffoldMessenger.of(context)
                                    ..hideCurrentSnackBar()
                                    ..showSnackBar(snackBar);
                                } else {
                                  final snackBar = SnackBar(
                                    /// need to set following properties for best effect of awesome_snackbar_content
                                    elevation: 0,
                                    /*duration: const Duration(
                                      milliseconds: 3000),*/
                                    behavior: SnackBarBehavior.floating,
                                    backgroundColor: Colors.transparent,
                                    content: AwesomeSnackbarContent(
                                      title: 'Error!',
                                      message: "Something went wrong",

                                      /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                                      contentType: ContentType.success,
                                    ),
                                  );
                                  if (!mounted) return;
                                  ScaffoldMessenger.of(context)
                                    ..hideCurrentSnackBar()
                                    ..showSnackBar(snackBar);
                                }
                              },
                              style: ButtonStyle(
                                padding: MaterialStateProperty.all(
                                    const EdgeInsets.all(0)),
                                elevation: MaterialStateProperty.all(1.0),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8))),
                                backgroundColor: MaterialStateProperty.all(
                                  const Color(0xffA00000),
                                ),
                                shadowColor: MaterialStateProperty.all(
                                    Theme.of(context).colorScheme.onSurface),
                              ),
                              child: const Text(
                                'Add',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: const Color(0xffA00000),
                          borderRadius: BorderRadius.circular(14.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 20.0),
                          child: Row(
                            children: const [
                              Expanded(
                                flex: 6,
                                child: Text(
                                  'Id',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              // SizedBox(width: 50.0,),
                              Expanded(
                                flex: 6,
                                child: Text(
                                  'Category Name',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: SizedBox(
                          height: 100,
                          child: FutureBuilder(
                              future: null,
                              builder: (context, snapshot) {
                                return ListView.builder(
                                    itemCount: 1,
                                    itemBuilder: (context, snapshot) {
                                      return Row(
                                        children: [
                                          const Expanded(
                                            flex: 6,
                                            child: Text(
                                              'Color',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15.0,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                          const Expanded(
                                            flex: 4,
                                            child: Text(
                                              'color',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15.0,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: SingleChildScrollView(
                                              child: Row(
                                                children: const [
                                                  Icon(
                                                    Icons.edit,
                                                    color: Color(0xffA00000),
                                                  ),
                                                  SizedBox(
                                                    width: 10.0,
                                                  ),
                                                  Icon(
                                                    Icons.delete,
                                                    color: Color(0xffA00000),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    });
                              }),
                        ),
                      ),
                      const SizedBox(height: 48),
                    ]))),
            PrimaryButton(
                text: 'Save',
                onTap: () async {
                  dynamic response = await updateStore(
                      token: globals.token,
                      name: name,
                      description: description,
                      url: url,
                      address: address,
                      latitude: 20,
                      longitude: 20,
                      categories: categories,
                      logo: "",
                      cover: "");
                  if (response != null) {
                    // TODO display snackbar with response as text content
                  } else {
                    // TODO display error message
                  }
                  //Navigator.pop(context);
                })
* */