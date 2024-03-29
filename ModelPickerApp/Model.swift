//
//  Model.swift
//  ModelPickerApp
//
//  Created by Kenneth Jackson on 11/1/20.
//

import UIKit
import RealityKit
import Combine

class Model {
    var modelName: String
    var image: UIImage
    var modelEntity: ModelEntity?
    
    private var cancellable: AnyCancellable? = nil
    
    init(modelName: String) {
        self.modelName = modelName
        
        self.image = UIImage(named: modelName)!
        
        let filename = modelName + ".usdz"
        self.cancellable = ModelEntity.loadModelAsync(named: filename)
            .sink(receiveCompletion: { loadCompletion in
                //Handle error
                print("DEBUG: Unable to load modelEntity for modelName \(self.modelName)")
            }, receiveValue: { modelEntity in
                //Get our model entity
                self.modelEntity = modelEntity
                print("DEBUG: Successfully load modelEntity for modelName \(self.modelName)")
            })
    }
}
