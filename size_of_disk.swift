class Track {
	var trackId: Int?
	init(trackId: Int)
	{
		self.trackId = trackId
	}
	func calculateSizeOfTrack() -> Int{
		var sizeOfTrack = 512
		return sizeOfTrack
	}
}
class Sector {
	var listOfTracks = [Track]()
	init(listOfTracks: [Track]) {
		self.listOfTracks = listOfTracks
	}
	func calculateSizeOfSector() -> Int {
		var sizeOfSector = 0 
		for i in 0..<listOfTracks.count {
			sizeOfSector += listOfTracks[i].calculateSizeOfTrack()
		}
		return sizeOfSector
	}
}
class Disk {
	var listOfSectors = [Sector]()
	init(listOfSectors: [Sector]) {
		self.listOfSectors = listOfSectors
	}
	func calculateSizeOfDisk() -> Int {
		var sizeOfDisk = 0 
		for i in 0..<listOfSectors.count {
			sizeOfDisk += listOfSectors[i].calculateSizeOfSector()
		}
		return sizeOfDisk
	}
}
class Raid {
	var listOfDisks = [Disk]()
	init(listOfDisks: [Disk]) {
		self.listOfDisks = listOfDisks
	}
	func calculateSizeOfRaid() -> Int {
		var sizeOfRaid = 0 
		for i in 0..<listOfDisks.count {
			sizeOfRaid += listOfDisks[i].calculateSizeOfDisk()
		}
		return sizeOfRaid
	}
}
class Raid0: Raid {
	var percentageUsedForBackup: Float?
	init(listOfDisks: [Disk], percentageUsedForBackup: Float) {
		super.init(listOfDisks: listOfDisks)
		self.percentageUsedForBackup = percentageUsedForBackup
	}
	func calculateSizeOfMemoryAvailable() -> (Float,Float) {
		var raidSize = calculateSizeOfRaid()
		var backUpSize: Float = (percentageUsedForBackup! / 100.0) * Float(raidSize)
		var memoryAvailable = Float (Float(raidSize) - backUpSize)
		return (memoryAvailable, backUpSize)
	}
}
var track1 = Track(trackId: 42)
var track2 = Track(trackId: 43)
var sector1 = Sector(listOfTracks: [track1,track2])
var disk1 = Disk(listOfSectors: [sector1])
var disk2 = Disk(listOfSectors: [sector1])
var raid1 = Raid0(listOfDisks: [disk1,disk2], percentageUsedForBackup: 10)
println("Size of memory available: \(raid1.calculateSizeOfMemoryAvailable().0) bytes")
println("Size of Back up: \(raid1.calculateSizeOfMemoryAvailable().1) bytes")