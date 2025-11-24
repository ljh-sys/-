### 1. 列表去重

**题目:** 给定一个包含重复元素的 `ArrayList`，编写一个方法，去除其中的重复元素，并保持元素的原始顺序。

**代码:**
```java
import java.util.ArrayList;
import java.util.LinkedHashSet;
import java.util.List;

public class ListDeduplication {

    public static <T> List<T> deduplicate(List<T> list) {
        // 使用 LinkedHashSet 来去重并保持顺序
        return new ArrayList<>(new LinkedHashSet<>(list));
    }

    public static void main(String[] args) {
        List<Integer> numbers = new ArrayList<>();
        numbers.add(1);
        numbers.add(2);
        numbers.add(3);
        numbers.add(2);
        numbers.add(1);
        numbers.add(4);

        System.out.println("Original list: " + numbers); // 原始列表
        List<Integer> deduplicatedList = deduplicate(numbers);
        System.out.println("Deduplicated list: " + deduplicatedList); // 去重后的列表
    }
}
```
**简要注释:** 利用 `LinkedHashSet` 既能保证元素唯一性又能维持插入顺序的特性，可以非常方便地实现列表去重。

### 2. 反转链表

**题目:** 使用 `LinkedList` 实现一个方法，该方法能够反转一个 `LinkedList` 中元素的顺序，要求在原列表上进行操作，而不是创建一个新的列表。

**代码:**
```java
import java.util.LinkedList;
import java.util.ListIterator;

public class ReverseLinkedList {

    public static <T> void reverse(LinkedList<T> list) {
        // 使用 Collections.reverse() 方法可以更简洁
        // java.util.Collections.reverse(list);

        // 手动实现反转
        if (list == null || list.size() <= 1) {
            return;
        }
        for (int i = 0; i < list.size() / 2; i++) {
            T temp = list.get(i);
            list.set(i, list.get(list.size() - 1 - i));
            list.set(list.size() - 1 - i, temp);
        }
    }

    public static void main(String[] args) {
        LinkedList<String> languages = new LinkedList<>();
        languages.add("Java");
        languages.add("Python");
        languages.add("C++");
        languages.add("JavaScript");

        System.out.println("Original list: " + languages);
        reverse(languages);
        System.out.println("Reversed list: " + languages);
    }
}
```
**简要注释:** 通过遍历列表的前半部分，并将其元素与后半部分对应的元素进行交换，可以实现 `LinkedList` 的原地反转。

### 3. 查找重复字符串

**题目:** 给定一个字符串数组，使用 `HashSet` 找出所有重复的字符串。

**代码:**
```java
import java.util.HashSet;
import java.util.Set;

public class FindDuplicates {

    public static Set<String> findDuplicateStrings(String[] array) {
        Set<String> seen = new HashSet<>();
        Set<String> duplicates = new HashSet<>();
        for (String s : array) {
            // 如果 add 方法返回 false，说明元素已存在
            if (!seen.add(s)) {
                duplicates.add(s);
            }
        }
        return duplicates;
    }

    public static void main(String[] args) {
        String[] words = {"apple", "banana", "apple", "orange", "banana", "grape"};
        Set<String> duplicateWords = findDuplicateStrings(words);
        System.out.println("Duplicate words are: " + duplicateWords); // 重复的单词
    }
}
```
**简要注释:** `HashSet` 的 `add` 方法在添加一个已经存在的元素时会返回 `false`。利用这个特性，我们可以高效地找出所有重复的元素。

### 4. 自定义对象排序

**题目:** 创建一个 `Student` 类，包含姓名(`name`)和分数(`score`)。将多个 `Student` 对象存入 `TreeSet`，并实现按分数降序排序。

**代码:**
```java
import java.util.Comparator;
import java.util.TreeSet;

class Student {
    String name;
    int score;

    public Student(String name, int score) {
        this.name = name;
        this.score = score;
    }

    @Override
    public String toString() {
        return "Student{" + "name='" + name + "'" + ", score=" + score + '}' ;
    }
}

public class CustomObjectSorting {
    public static void main(String[] args) {
        // 使用 Lambda 表达式创建比较器，实现降序排序
        Comparator<Student> scoreComparator = (s1, s2) -> s2.score - s1.score;

        TreeSet<Student> students = new TreeSet<>(scoreComparator);
        students.add(new Student("Alice", 85));
        students.add(new Student("Bob", 92));
        students.add(new Student("Charlie", 78));
        students.add(new Student("David", 92)); // 分数相同，可能覆盖，取决于比较器实现

        students.forEach(System.out::println);
    }
}
```
**简要注释:** 要在 `TreeSet` 中存储自定义对象，需要为 `TreeSet` 提供一个 `Comparator`，或者让自定义类实现 `Comparable` 接口，以定义排序规则。

### 5. 统计字符频率

**题目:** 编写一个程序，使用 `HashMap` 计算一个给定字符串中每个字符出现的次数。

**代码:**
```java
import java.util.HashMap;
import java.util.Map;

public class CharacterFrequency {

    public static Map<Character, Integer> countFrequency(String text) {
        Map<Character, Integer> frequencyMap = new HashMap<>();
        for (char c : text.toCharArray()) {
            // 使用 getOrDefault 方法简化代码
            frequencyMap.put(c, frequencyMap.getOrDefault(c, 0) + 1);
        }
        return frequencyMap;
    }

    public static void main(String[] args) {
        String message = "hello world";
        Map<Character, Integer> frequency = countFrequency(message);
        System.out.println("Character frequencies: " + frequency);
    }
}
```
**简要注释:** `HashMap` 是存储键值对的理想选择。遍历字符串，将字符作为键，出现次数作为值，即可统计频率。

### 6. 筛选高分学生

**题目:** 有一个存储学生姓名和分数的 `TreeMap`。编写一个方法，找出所有分数高于90分的学生。

**代码:**
```java
import java.util.Map;
import java.util.TreeMap;

public class FilterStudents {

    public static Map<String, Integer> getHighScorers(TreeMap<String, Integer> scores) {
        Map<String, Integer> highScorers = new TreeMap<>();
        for (Map.Entry<String, Integer> entry : scores.entrySet()) {
            if (entry.getValue() > 90) {
                highScorers.put(entry.getKey(), entry.getValue());
            }
        }
        return highScorers;
    }

    public static void main(String[] args) {
        TreeMap<String, Integer> studentScores = new TreeMap<>();
        studentScores.put("Alice", 88);
        studentScores.put("Bob", 95);
        studentScores.put("Charlie", 91);
        studentScores.put("David", 76);

        Map<String, Integer> highAchievers = getHighScorers(studentScores);
        System.out.println("Students with scores > 90: " + highAchievers);
    }
}
```
**简要注释:** 遍历 `TreeMap` 的 `entrySet`，检查每个条目的值（分数），如果满足条件，则将其添加到结果 `Map` 中。

### 7. 模拟排队系统

**题目:** 使用 `ArrayDeque` 作为队列，模拟一个简单的排队叫号系统。不断有新人加入队尾，系统按顺序处理队首的人。

**代码:**
```java
import java.util.ArrayDeque;
import java.util.Queue;

public class QueueSimulation {
    public static void main(String[] args) {
        Queue<String> waitingLine = new ArrayDeque<>();

        // 顾客进入队列
        waitingLine.offer("Customer 1");
        waitingLine.offer("Customer 2");
        waitingLine.offer("Customer 3");

        System.out.println("Current queue: " + waitingLine);

        // 处理顾客
        while (!waitingLine.isEmpty()) {
            String currentCustomer = waitingLine.poll();
            System.out.println("Serving: " + currentCustomer); // 正在服务
            try {
                Thread.sleep(1000); // 模拟服务耗时
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
        System.out.println("All customers have been served."); // 所有顾客服务完毕
    }
}
```
**简要注释:** `ArrayDeque` 是一个高效的双端队列，可以作为队列（FIFO）使用。`offer` 方法用于入队，`poll` 方法用于出队。

### 8. 括号平衡检查

**题目:** 利用 `ArrayDeque` 作为栈，编写一个程序来检查一个包含 '(', ')', '{', '}', '[', ']' 的字符串中的括号是否平衡。

**代码:**
```java
import java.util.ArrayDeque;
import java.util.Deque;

public class BalancedBrackets {

    public static boolean isBalanced(String s) {
        Deque<Character> stack = new ArrayDeque<>();
        for (char c : s.toCharArray()) {
            if (c == '(' || c == '{' || c == '[') {
                stack.push(c); // 左括号入栈
            } else if (c == ')' && !stack.isEmpty() && stack.peek() == '(') {
                stack.pop(); // 匹配成功，出栈
            } else if (c == '}' && !stack.isEmpty() && stack.peek() == '{') {
                stack.pop();
            } else if (c == ']' && !stack.isEmpty() && stack.peek() == '[') {
                stack.pop();
            } else {
                return false; // 不匹配的右括号
            }
        }
        return stack.isEmpty(); // 栈为空则所有括号都已匹配
    }

    public static void main(String[] args) {
        String expr1 = "{[()]}";
        String expr2 = "{[(])}";
        System.out.println(expr1 + " is balanced: " + isBalanced(expr1));
        System.out.println(expr2 + " is balanced: " + isBalanced(expr2));
    }
}
```
**简要注释:** `ArrayDeque` 也可以用作栈（LIFO）。遍历字符串，遇到左括号就入栈，遇到右括号则检查栈顶是否为匹配的左括号。

### 9. 查找第K大的元素

**题目:** 使用 `PriorityQueue` 在一个未排序的整数数组中找到第 `k` 大的元素。

**代码:**
```java
import java.util.PriorityQueue;

public class KthLargestElement {

    public static int findKthLargest(int[] nums, int k) {
        // 创建一个最小堆
        PriorityQueue<Integer> minHeap = new PriorityQueue<>();
        for (int num : nums) {
            minHeap.add(num);
            // 如果堆的大小超过 k，则移除堆顶的最小元素
            if (minHeap.size() > k) {
                minHeap.poll();
            }
        }
        // 最终堆顶的元素就是第 k 大的元素
        return minHeap.peek();
    }

    public static void main(String[] args) {
        int[] numbers = {3, 2, 1, 5, 6, 4};
        int k = 2;
        System.out.println("The " + k + "nd largest element is: " + findKthLargest(numbers, k)); // 第2大的元素
    }
}
```
**简要注释:** 维护一个大小为 `k` 的最小堆。遍历数组，将元素加入堆中，当堆大小超过 `k` 时，移除堆顶的最小元素。遍历结束后，堆顶元素即为第 `k` 大的元素。

### 10. 按字符串长度排序

**题目:** 给定一个 `ArrayList` of `String`，使用 `Collections.sort()` 和自定义 `Comparator`，按字符串的长度对其进行升序排序。

**代码:**
```java
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

public class SortByLength {
    public static void main(String[] args) {
        List<String> fruits = new ArrayList<>();
        fruits.add("peach");
        fruits.add("apple");
        fruits.add("banana");
        fruits.add("kiwi");

        System.out.println("Original list: " + fruits);
        
        // 使用 Lambda 表达式实现 Comparator
        Collections.sort(fruits, (s1, s2) -> Integer.compare(s1.length(), s2.length()));
        
        System.out.println("Sorted by length: " + fruits); // 按长度排序
    }
}
```
**简要注释:** `Collections.sort()` 方法可以接受一个 `Comparator` 作为参数，以实现自定义的排序逻辑。这里使用 Lambda 表达式创建了一个比较器，用于比较字符串的长度。
