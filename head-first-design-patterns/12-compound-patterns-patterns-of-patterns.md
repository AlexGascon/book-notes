## Chapter 12: Compound Patterns: Patterns of Patterns 


#### Exercise
_What if a Quackologist wants to observe an entire flock? What does that mean anyway? Think about it like this: if we observe a composite, then we’re observing everything in the composite. So, when you register with a flock, the flock composite makes sure you get registered with all its children (sorry, all its little quackers), which may include other flocks.

Go ahead and write the Flock observer code before we go any further._

```java
public class Flock implements Quackable {
	ArrayList<Quackable> quackers = new ArrayList<Quackable>();
	ArrayList<Observers> observers = new ArrayList<Observers>();

	public void add(Quackable quacker) {
		quackers.add(quacker);
		addExistingObservers(quacker);
	}

	public void quack() {
		for (Quack quacker : quackers) {
			quacker.quack();
			quacker.notifyObservers();
		}
	}

	public void registerObserver(Observer observer) {
		observers.add(observer);

		for (Quack quacker : quackers)
			quacker.registerObserver(observer);
	}

	public void notifyObservers() {
		for (Quack quacker : quackers)
			quacker.notifyObservers();
	}

	private void addExistingObservers(Quackable quacker) {
		for (Observer observer : observers)
			quacker.registerObserver(observer);
	}
}
```

