//
//  ViewController.swift
//  ConnectFourTutorial
//
//  Created by CallumHill on 20/11/21.
//

import UIKit
import AVKit
import AVFoundation


class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource  {
    var aPlayer: AVAudioPlayer?


    @IBOutlet weak var playerTurn: UILabel!

	@IBOutlet weak var collectionView: UICollectionView!
    
	@IBOutlet weak var turnImage: UIImageView!
    
    
	
    
	var redScore = 0
	var yellowScore = 0
    var numberOfRoundsOne = 0
    var collectionViewHeightConstraint: NSLayoutConstraint?

    
	
	override func viewDidLoad()
	{
		super.viewDidLoad()
    
        viewDidLayoutSubviews()
       
		resetBoard()
		
        setupAudioPlayer2()
        
       
        
        if let path = Bundle.main.path(forResource: "gameMusic", ofType: "mp3") {
                    let url = URL(fileURLWithPath: path)
                    do {
                        aPlayer = try AVAudioPlayer(contentsOf: url)
                        aPlayer?.play()
                        aPlayer?.numberOfLoops = -1
                    } catch {
                        print("Error loading audio file")
                    }
                }


	}
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setCellWidthHeight()
           collectionView.reloadData()
        
    }


    func setCellWidthHeight() {
        let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        var width: CGFloat = 0
        var height: CGFloat = 0
        
        if UIDevice.current.orientation.isLandscape {
            width = collectionView.frame.size.width / 8
            height = collectionView.frame.size.height / 4
            
            collectionView.clipsToBounds = true
        } else if UIDevice.current.orientation.isPortrait {
            width = collectionView.frame.size.width / 9
            height = collectionView.frame.size.height / 6
            collectionView.clipsToBounds = true
        }
        
        flowLayout.itemSize = CGSize(width: width, height: height)
        
        // Add constraints to ensure collection view stays within bounds of view
        //   collectionView.translatesAutoresizingMaskIntoConstraints = tr
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        coordinator.animate(alongsideTransition: { [weak self] _ in
            self?.setCellWidthHeight()
            self?.collectionView.reloadData()
        }, completion: nil)
    }
        //

	func numberOfSections(in cv: UICollectionView) -> Int
	{
		return board.count
	}
	
	func collectionView(_ cv: UICollectionView, numberOfItemsInSection section: Int) -> Int
	{
		return board[section].count
	}

	func collectionView(_ cv: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
	{
		let cell = cv.dequeueReusableCell(withReuseIdentifier: "idCell", for: indexPath) as! BoardCell
		
		let boardItem = getBoardItem(indexPath)
		cell.image.tintColor = boardItem.tileColor()
		return cell
	}
    
  

	
	func collectionView(_ cv: UICollectionView, didSelectItemAt indexPath: IndexPath)
	{
		let column = indexPath.item
		if var boardItem = getLowestEmptyBoardItem(column)
		{
			if let cell = collectionView.cellForItem(at: boardItem.indexPath) as? BoardCell
			{
				cell.image.tintColor = currentTurnColor()
				boardItem.tile = currentTurnTile()
				updateBoardWithBoardItem(boardItem)
                
                
              
				if victoryAchieved()
                    
				{
                    
					if yellowTurn()
                        
                       
					{
                       
                        
                      
                       
                    
                        // the problem I was having is that yellowTurn  goes for every code block. so what that means is yellowturn goes for every if else in the code, ao I just did a if statement in yellowT\Turn to make if redScore == 4 have its own logic. Since 4 makes the game end.
          
                        
                        
                        
                     
						numberOfRoundsOne += 1
                        yellowScore += 1
                       
                   
                         
                        if yellowScore == 4 {
                            resultAlert(("Congrats Yellow! You won the seies of 7!"))
                            yellowScore = 0
                            redScore = 0
                            numberOfRoundsOne = 0
                            
                        }
                            
                               resultAlert("Yellow you won this round! Keep going you might win the prize!!!")
                        
                
                            
                               if yellowScore == 2 {
                              
                              
                                  
                                   resultAlert("Yellow you won this round! Keep going you might win the prize!!!")
                               }
                               
                             
                             
                               if yellowScore == 3 {
                                   
                               
                                  
                                   resultAlert("Yellow you won this round! Keep going you might win the prize!!!")
                                   
                               }
                       
                  if yellowScore == 4 {
                         
                                  yellowScore = 0
                                redScore = 0
                                resultAlert("Congrats Yellow! You won the seies of 7!")
                            
                              
                    
                            
                        }
                    
                            
                        
         // nbao
                    
                        
					}
					
					if redTurn()
                        // the problem I was having is that redTurn  goes for every code block. so what that means is redturn goes for every if else in the code, ao I just did a if statement in redTurn to make if redScore == 4 have its own logic. Since 4 makes the game end.
                        
                     
                      
					{
                        
                      
                        
                     
                 
                        numberOfRoundsOne += 1
                        redScore += 1
                        
                        if redScore == 4 {
                        resultAlert(("Congrats Red! You won the seies of 7! You have won 5.50$"))
                            redScore = 0
                            yellowScore = 0
                            numberOfRoundsOne = 0
                        
                    }
                      
                           
                         
                            resultAlert("Red you won this round! Keep going you might win the prize!!!")
                           
                        
                       
                    
                     
                        
                        if redScore == 2 {
                            
                          
                          
                          
                            resultAlert("Red you won this round! Keep going you might win the prize!!!")
                         
                        }
                     
                      
                        
                        if redScore == 3 {
                            
                          
                          
                            
                            resultAlert("Red you won this round! Keep going you might win the prize!!!")
                           
                           
                        }
                      
                  
                       
                        if redScore == 4 {
                          
                           
                           redScore = 0
                            yellowScore = 0
                            resultAlert("Congrats Red! You won the seies of 7! You have won 5.50$")
                          
                            
                         
                           
                            
                           
                            
                            
                           
                            
                        }
                        resultAlert("\(currentTurnVictoryMessage())")
                       
                        
                       
                       
                       
					}
                   
					
				}
				
				if boardIsFull()
				{
					resultAlert("Draw")
				}
				
                toggleTurn(turnImage, playerTurn)
			}
		}
	}
	
	func resultAlert(_ title: String)
	{
		let message = "\nRed: " + String(redScore) + "\n\nYellow: " + String(yellowScore)
		let ac = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
		ac.addAction(UIAlertAction(title: " Round \(numberOfRoundsOne) Completed!!!", style: .default, handler: {
			[self] (_) in
			resetBoard()
            self.resetCells()
           
		}))
		self.present(ac, animated: true)
	}
	
	func resetCells()
	{
		for cell in collectionView.visibleCells as! [BoardCell]
		{
			cell.image.tintColor = .white
		}
	}
    
    func setupAudioPlayer2() {
           guard let url = Bundle.main.url(forResource: "gameMusic", withExtension: "mp3") else {
               return
           }
           
           do {
               aPlayer = try AVAudioPlayer(contentsOf: url)
               aPlayer?.prepareToPlay()
               aPlayer?.numberOfLoops = -1
           } catch {
               print("Error loading audio file: \(error)")
           }
       }
    

}

