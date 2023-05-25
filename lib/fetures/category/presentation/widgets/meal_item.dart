import 'package:flutter/material.dart';
import 'package:flutter_meals/fetures/category/data/models/meal.dart';
import 'package:flutter_meals/fetures/category/presentation/widgets/meal_item_trait.dart';
import 'package:transparent_image/transparent_image.dart';

class MealItem extends StatelessWidget {
  const MealItem({
    super.key,
    required this.meal,
    required this.onSelectMeal,
  });

  final Meal meal;
  final Function(BuildContext context, Meal meal) onSelectMeal;

  //TODO : Complexity text format
  //ดึงข้อมูล meal.complexity จาก enum
  String get complexityText {
    //ต้องการรูปแบบ 'S' + 'imple' = 'Simple'
    return meal.complexity.name[0].toUpperCase() +
        meal.complexity.name.substring(1);
  }

  //TODO : Affordability text format
  //ดึงข้อมูล meal.complexity จาก enum
  String get affordabilityText {
    //ต้องการรูปแบบ 'S' + 'imple' = 'Simple'
    return meal.affordability.name[0].toUpperCase() +
        meal.affordability.name.substring(1);
  }

//========================================================================================================================
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      clipBehavior: Clip.hardEdge, //ทำให้ขอบมนได้
      elevation: 2, //เงา
      child: InkWell(
        onTap: () {
          onSelectMeal(context,meal);
        },
        child: Stack(
          children: [
            //TODO 1: Image Fade
            //Hero = การสร้างอนิเมชันแบบต่อเนื่อง ระหว่างการเปลี่ยนหน้า
            Hero(
               //ทำให้สามารถรู้จักและจับคู่ Hero ให้ตรงกันระหว่างหน้าต้นฉบับและหน้าปลายทาง
               //!ต้องมี Hero ทั้งคู่
              tag: meal.id,
              child: FadeInImage(
                //placeholder = dแสดงถ้ารูปยังโหลดไม่เสร็จ
                placeholder: MemoryImage(kTransparentImage),
                image: NetworkImage(meal.imageUrl),
                fit: BoxFit.cover,
                //ที่กำหนดแบบนี้ก็เพื่อให้ขนาดเท่าๆ กัน
                height: 200,
                width: double.infinity,
              ),
            ),

            //TODO 2: Badge Text title
            Positioned(
              //*1. กำหนดตำแหน่ง widget black
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                color: Colors.black54,
                padding:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 44),
                child: Column(
                  children: [
                    //*2. title text
                    Text(
                      meal.title,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      softWrap: true, //แบ่งบรรทัดเมื่อข้อความเกิน
                      overflow: TextOverflow.ellipsis, //ถ้าเกินจะเติม ...
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 12),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //*3. เวลาในการทำอาหาร
                        MealItemTrait(
                          icon: Icons.schedule,
                          label: "${meal.duration} min.",
                        ),
                        const SizedBox(width: 12),

                        //*4. ความยากในการทำอาหาร
                        MealItemTrait(
                          icon: Icons.work,
                          label: complexityText,
                        ),
                        const SizedBox(width: 12),

                        //*5. ระดับราคา
                        MealItemTrait(
                          icon: Icons.attach_money,
                          label: affordabilityText,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
