"""Student Dormitory System - қарапайым үлгісі."""


class Room:
    def __init__(self, number: int, capacity: int):
        self.number = number
        self.capacity = capacity
        self.students: list[str] = []

    def is_full(self) -> bool:
        return len(self.students) >= self.capacity

    def add_student(self, name: str) -> bool:
        if self.is_full():
            return False
        self.students.append(name)
        return True


class Dormitory:
    def __init__(self):
        self.rooms: list[Room] = []

    def add_room(self, number: int, capacity: int) -> Room:
        room = Room(number, capacity)
        self.rooms.append(room)
        return room

    def place_student(self, room_number: int, name: str) -> bool:
        for room in self.rooms:
            if room.number == room_number:
                return room.add_student(name)
        return False

    def list_rooms(self) -> None:
        for room in self.rooms:
            print(f"Бөлме {room.number}: {len(room.students)}/{room.capacity} студент")


if __name__ == "__main__":
    dorm = Dormitory()
    dorm.add_room(101, 2)
    dorm.place_student(101, "Айдар")
    dorm.list_rooms()
// feature
