# Korean Restaurant Sales Analysis & 2025 Growth Strategy
## TL;DR (Summary)
-  **Problem:** Sales declined by **22.7%** over the last four months, primarily due to reduced dine-in traffic.
- **Key Insights:**
  - Dine-in contributes **90.1% of total revenue**, but weekday sales are weak.
  - Late-night alcohol sales remain steady, but food orders decline after 9 PM.
  - Delivery sales have grown but still only make up **9.9% of total revenue**.
- **2025 Growth Strategy:**
  - **Increase weekday dine-in traffic** via happy hour promotions and premium alcohol upsells.
  - **Boost late-night revenue** through group alcohol discounts & "Second Round" promotions.
  - **Expand delivery & takeout** via curated meal bundles and first-time order discounts.
  - **Leverage K-culture marketing** with K-pop nights, influencer campaigns & social media challenges.
<br><br>
## 1. Business Problem

This project analyzes the performance of a **Korean franchise restaurant in Irvine, CA**, part of a globally recognized brand founded by **renowned chef Baek Jong-won**. With increasing international recognition through **Netflix** and other media, the restaurant has gained attention among Korean food enthusiasts in the U.S.

Despite an initially strong performance, sales have declined over the past four months. This report aims to **identify key drivers of this decline and develop data-driven strategies for revenue growth in 2025**.

A major competitive advantage is the restaurant’s **late-night operations(open until midnight on weekdays and 1 AM on weekends)**, making it the **only soju pub concept in Irvine**. This unique positioning offers opportunities to attract late-night customers and stand out in the market.

Through **SQL-based data analysis and Tableau insights**, this project explores sales trends, evaluates performance gaps, and provides actionable strategies to optimize operations, enhance customer engagement, and drive sustainable growth.
<br><br>
## 2. Data Overview

The analysis utilizes two datasets:

- Sales Data: Includes order details, total revenue, category breakdown, and time-based trends.
- Item Sales Data: Contains sales performance by menu item, category, and order type(Dine-in, Takeout, Delivery).
<br><br>
## 3. Key Analysis & Insights

### **3.1 2024 Overall Sales**

- 2024 Total Revenue: $1.53M from approximately 18K total orders. Since opening in December 2023, the restaurant initially saw strong performance but has experienced a gradual decline of approximately 22.7% over the past four months, primarily due to a drop in dine-in traffic.
- Average Order Value (AOV):
    - Dine-in: $91.5 (Key revenue driver, accounting for 90% of total sales)
    - Delivery: $51.04 (44% lower than Dine-in, but stable in volume, comprising 6% of total revenue).
- Customer Traffic Trend:
    - Average daily ticket count dropped from 55 in May to 45 in September(-18.2%), indicating a decline in overall customer volume.
    - AOV remained relatively stable, suggesting that the revenue drop is primarily driven by a decrease in the number of transactions rather than order size.
    - Further analysis on Dine-in vs. Delivery trends will provide insights into optimizing sales strategies for 2025.
    

### 3.2 Time-Based Sales Trends

- **Monthly Trends**:
    - Sales peaked in May ($148.4K) but declined steadily from June onward, reaching the lowest point in in September($114.7K), primarily due to the temporary departure of international students and foreign workers during summer.
    - Irvine’s large Asian population (44.1%), including many Chinese and Korean students and professionals, frequently travels abroad during this period, leading to reduced customer foot traffic.
    - Additionally, economic uncertainty and rising living costs contributed to more cautious spending behavior, particularly among young professionals in their 30s, a key customer segment for the restaurant.
    - Although sales slightly recovered after September, they remained below mid-year levels, reflecting lasting impacts from seasonal population shifts and changing consumer behavior.
    - The revenue decline directly correlates with fewer transactions, confirming that lower customer volume was the primary driver.

<img width="1200" alt="image" src="https://github.com/user-attachments/assets/918b019a-2eff-4978-8082-a45a8ea6f652" />
<br><br> 

- **Weekly Trends:**
    - Friday and Saturday contribute nearly 40% of total weekly sales, driven by late-night dining demand and group gatherings.
        - Friday: $375.6K / 75 tickets per day
        - Saturday: $341.3K / 72 tickets per day
    - Monday and Tuesday have the lowest revenue, as consumers cut back on spending after the weekend and settle into weekday routines, opting for home-cooked meals or lower-cost dining options.
        - Monday: $135.1K / 32 tickets per day
    - Customer traffic is lowest between Monday and Wednesday, gradually increasing towards the weekend.
    - Average order value(AOV) remains relatively stable, peaking on Friday at $95.98 and dipping to $80.06 on Monday.
    - This pattern is influenced by financial constraints, as consumers allocate more of their budget to weekend dining, while lower weekday demand, especially for late-night dining, further widens the gap.
        
<img width="1200" alt="image" src="https://github.com/user-attachments/assets/7b7c23cb-5725-4131-9f2c-9644ca3c139a" />
<br><br>         
    
- **Hourly Trends:**
    - 6 PM - 8 PM is the most profitable period, indicating a strong dinner rush with high customer traffic.
    - The highest average order value ($98.80) occurs at 7 PM, driven by peak dinner demand, group dining, and larger food orders.
    - After 8 PM, AOV and ticket count gradually decline, as customers transition from full meals to lighter snacks and drinks.
    - Sales remain steady around 9 PM, with a slight uptick in ticket count, likely driven by late-night drink orders. However, food orders continue to decline, leading to lower overall revenue.
    - Late-night sales could be improved through targeted promotions and menu strategies. *(detailed recommendations in the next section)*
    - Optimizing peak-hour service efficiency and upselling strategies could maximize revenue. *(detailed recommendations in the next section)*
  
 <img width="1200" alt="image" src="https://github.com/user-attachments/assets/f72e990a-2bb6-4756-94d7-281314294cd6" />
<br><br>    

### **3.3 Dine-In vs. Delivery(inc. Takeout) Performance Analysis**

- **Dine-In Trends:**
    - Dine-in generates 90.1% of total revenue, making it the core revenue driver.
    - Alcohol sales play a key role in dine-in revenue, reinforcing the soju pub concept.
        - Alcohol purchases are significantly higher for dine-in compared to delivery/takeout, aligning with the restaurant’s positioning as a late-night social venue.
        - Revenue fluctuations are closely tied to group dining sizes, as larger parties drive higher spending.
    - Consumer demand is concentrated on weekends, with higher ticket sizes on Fridays and Saturdays due to increased alcohol consumption and social gatherings.
    - Weekday traffic is noticeably lower, indicating a potential gap in weekday demand.
    
- **Delivery & Takeout Trends:**
    - Delivery & takeout contribute 9.9% of total revenue but have shown steady growth since launching in February.
    - Unlike dine-in, delivery orders focus on food items(e.g., stews, fried chicken, rice-based dishes), leading to different spending patterns.
    - Despite platform commission fees, higher menu pricing ensures that delivery margins remain comparable to dine-in sales.
    - While delivery sales have increased, they have not fully offset the decline in direct dine-in sales.
    - Delivery demand peaks between 7 PM - 9 PM but drops sharply after 9 PM, likely due to limited late-night delivery interest.

<img width="346" alt="image" src="https://github.com/user-attachments/assets/88686e5d-df69-4461-bf78-e5d10379a040" /> | <img width="1200" alt="image" src="https://github.com/user-attachments/assets/7aa72dd5-389e-4b09-bf97-d7896ff807c0" />
---|---|
<br><br> 


### 3.4 Order Type-Based Menu Performance Analysis

### Overall Category Sales Breakdown

- Entrees (33.8%) and Alcohol (23.9%) together generate over half of total revenue, making them the most critical categories for sustaining sales and profitability. Alcohol’s high margin directly boosts AOV, reinforcing the restaurant’s soju pub positioning.
- Combos (12.8%) and Soup & Jeongol (11.0%) perform strongly, reflecting high demand for shared meals and group dining experiences. These categories align with Korean dining culture, where communal eating is the norm.
- Fried Chicken (10.8%) and Sides (6.8%) contribute smaller revenue shares but are frequently paired with alcohol, making them ideal upsell opportunities, especially for late-night dining.
- Top-selling items account for 46.01% of total revenue, while the bottom 10 items contribute just 0.006%, indicating the need to streamline the menu by removing or repackaging underperforming dishes.

<img width="462" alt="image" src="https://github.com/user-attachments/assets/f0e663ea-592a-463e-ae2a-8b04c3071422" />
<br><br> 

### Top 10 Best-Selling Items

- Soju leads sales at $130K, followed by Hanshin Dakbal($98K) and Bottled Beer($79K), confirming that alcohol and spicy dishes are core revenue drivers.
- Hanshin Dakbal, a signature dish that made the brand famous in Korea, continues to perform exceptionally well in the U.S. market, reinforcing its flagship status.
- Pork Mozzarella Cheese Fondue, Kimchi Jeongol, and Fried Chicken varieties rank among the top food items, showing strong demand for flavorful, shareable dishes that complement alcohol consumption.


### Best-Selling Items by Order Type

### Dine-in:

- Alcohol beverages(Soju & Bottled Beer) generate 23.9% of total revenue, confirming that alcohol sales are a key driver of dine-in profitability.
- Hanshin Dakbal($67.4K) remains a top dine-in item, reinforcing its strong appeal as a spicy dish that pairs well with alcohol. Kimchi Jeongol and Cheese Fondue also rank high, reflecting customer preference for rich, comforting meals.
- Combo menus contribute Y% of dine-in sales, further proving that group dining is a dominant revenue driver, especially on weekends.
- Dine-in preferences strongly align with late-night drinking culture, with alcohol and spicy dishes dominating sales.

### Delivery & Pick Up:

- Hanshin Dakbal ($14.1K) is also the best-selling pick-up item, showing that its appeal extends across order types.
- Fried and spicy dishes, such as Fried Whole Chicken and Kimchi Jeongol, perform best in delivery, supporting the idea that comfort foods drive takeout demand.
- DIY Rice Ball and Oden-tang rank in the top 10, reflecting demand for customizable or warm meal options.
- Kimchi Jeongol maintains strong performance across all order types, emphasizing its broad appeal and suitability for takeout due to easy reheating.
- Chicken-based dishes (e.g., Fried Whole Chicken, Yangnyeom Chicken) rank high in delivery sales, highlighting potential for expanding meal bundles optimized for takeout.
- Alcohol sales in delivery & pick-up remain minimal due to legal restrictions and consumer behavior, reinforcing the dine-in exclusivity of beverage revenue.

<img width="865" alt="image" src="https://github.com/user-attachments/assets/2a322b2c-6fc3-446c-8c79-dd3e8760be26" /> | <img width="870" alt="image" src="https://github.com/user-attachments/assets/f940f21d-8c80-4ce6-8712-04d774fff0ec" />
--|--

<br><br>
## **4. 2025 Growth Strategy & Business Recommendations**

### 4.1 Dine-In Optimization

Dine-in contributes 90.1% of total revenue, making it the restaurant’s core business driver. However, sales drop significantly on Monday & Tuesday(35% lower than weekends, averaging 32 tickets/day), indicating weak weekday traffic.

- To address this, weekday promotions such as "Lunch Specials" for local workers and students and "Happy Hour" (5-7 PM) discounts on appetizers & drinks can attract more customers. Additionally, upselling soju pairings & premium spirits can increase per-table spending.

-> Impact: These initiatives can increase weekday ticket volume by 10-15% while also improving AOV through alcohol sales.

### 4.2 Late-Night Sales Expansion

Although alcohol sales remain stable post-9 PM, food orders decline, and there’s only a slight rebound in ticket count at 9 PM. This suggests demand for late-night social drinking rather than full meals.

- Instead of focusing on food promotions, shifting efforts to alcohol sales can maximize revenue. A "Second Round Discount" (15% off the second bottle of soju/beer after 10 PM) and Beer/Soju Tower group deals can increase per-table spending and customer retention.

-> Impact: These targeted promotions could lead to a 15-20% increase in late-night revenue while keeping customers engaged for longer periods.

### 4.3 Delivery & Takeout Growth

Despite making up only 9.9% of total revenue, delivery orders are profitable due to higher menu pricing that offsets third-party fees. The best-performing delivery items include Kimchi Jeongol and Fried Chicken, indicating that comfort foods drive takeout demand.

- To increase order volume, bundling high-margin items into curated meal sets can improve AOV. Options like "K-Comfort Food Set" (Jeongol + Side Dishes) and "Game Night Fried Chicken Combo" can boost sales. Additionally, a 10% discount for first-time direct orders can shift customers from UberEats/DoorDash to in-house ordering.

-> Impact: These efforts could increase delivery order volume by 25-30% and improve takeout profitability.

### 4.4 Cultural & Marketing Engagement

With growing U.S. interest in Korean culture, food, and social drinking, leveraging K-pop, K-dramas, and social media trends can enhance brand visibility and customer engagement.

- Korean culture-themed promotions, such as "K-Pop Night" and "K-Drama Soju Pairing," can attract new customers, while social media challenges (e.g., "🔥 Spicy Dakbal Challenge") can increase organic engagement. Partnering with local influencers can also enhance brand awareness.

-> Impact: These strategies can drive higher foot traffic, increased social media reach, and improved brand recognition among younger audiences.
<br><br>
## **5. Conclusion**

The analysis of the restaurant’s sales performance, customer behavior, and order trends highlights key areas for improvement and growth opportunities in 2025. The decline in sales over the past four months has been primarily driven by reduced dine-in traffic, seasonal fluctuations, and lower weekday engagement. However, with targeted, data-driven strategies, these challenges can be addressed to drive revenue recovery and long-term growth.

Key takeaways from this analysis include:

- Dine-in is the primary revenue driver (90.1% of total sales), but weekday traffic remains weak.
    
    → Implementing weekday promotions and premium alcohol upsells can improve traffic and increase per-table spending.
    
- Late-night sales are sustained by alcohol purchases, but food orders decline after 9 PM.
    
    → Shifting late-night promotions toward alcohol and group-based deals can enhance revenue and customer retention.
    
- Delivery and takeout contribute 9.9% of total revenue but present an opportunity for growth.
    
    → Optimizing bundle pricing and offering first-time order incentives can increase order volume while maintaining profitability.
    
- Cultural marketing and digital engagement are essential for customer acquisition and brand positioning.
    
    → Leveraging Korean-themed promotions, influencer collaborations, and social media-driven campaigns can attract a broader audience.
    

By implementing these strategies, the restaurant can increase weekday traffic, maximize late-night sales, expand delivery revenue, and enhance brand visibility in 2025. The integration of SQL-based sales analysis and Tableau-driven visualizations ensures that these insights are backed by data, supporting informed business decisions.
<br><br>
## 6. Next Steps: Future Improvements

### 6.1 Expand Data Scope
   - Include competitor pricing & promotional data for a comparative analysis.
   - Analyze customer demographics for more targeted marketing.
### 6.2 Advanced Forecasting
   - Use time-series forecasting (e.g., ARIMA, Prophet) to predict future sales trends.
### 6.3 Real-time Analytics
   - Implement automated dashboards in Tableau for real-time sales monitoring.
### 6.4 Customer Feedback Analysis
   - Integrate sentiment analysis on Yelp & Google reviews to identify service improvement areas.

With a strategic focus on key revenue drivers and customer behavior patterns, the restaurant is well-positioned for sustainable growth in 2025 and beyond.
