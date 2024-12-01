//
//  TaskCell.swift
//  ToDoList
//
//  Created by Иван Бурцев on 28.11.2024.
//

import SwiftUI

struct TaskCell: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var dateHolder: DateHolder
    @ObservedObject var passedItem: TaskItem
    @State private var showEditModal = false
    @State private var isShareSheetPresented = false

    var body: some View {
        HStack {
            CheckBoxView(passedItem: passedItem)
                .environmentObject(dateHolder)
            VStack(alignment: .leading) {
                Text("\(passedItem.name ?? "")")
                    .fontWeight(.heavy)
                    .strikethrough(passedItem.IsCompleted() ? true : false, color: colorScheme == .dark ? .gray : .black)
                Text("\(passedItem.desc ?? "")")
                    .foregroundStyle(passedItem.IsCompleted() ? .gray : colorScheme == .dark ? .white : .black)
            }
            .contextMenu {
                Button {
                    showEditModal = true
                } label: {
                    Label("Редактировать", systemImage: "pencil")
                }

                Button {
                    shareTask()
                } label: {
                    Label("Поделиться", systemImage: "square.and.arrow.up")
                }

                Button(role: .destructive) {
                    deleteTask()
                } label: {
                    Label("Удалить", systemImage: "trash")
                }
            }
            .sheet(isPresented: $showEditModal) {
                TaskEditView(passedItem: passedItem, initialDate: Date())
                    .environmentObject(dateHolder)
            }
            .sheet(isPresented: $isShareSheetPresented) {
                ShareSheet(items: [passedItem.name ?? "Задача", passedItem.desc ?? "Описание"])
            }
        }

    }

    private func shareTask() {
        isShareSheetPresented = true
    }

    private func deleteTask() {
        withAnimation {
            let context = passedItem.managedObjectContext
            context?.delete(passedItem)

            do {
                try context?.save()
            } catch {
                print("Error delete task: \(error.localizedDescription)")
            }
        }
    }
}

struct ShareSheet: UIViewControllerRepresentable {
    let items: [Any]

    func makeUIViewController(context: Context) -> UIActivityViewController {
        return UIActivityViewController(activityItems: items, applicationActivities: nil)
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
    }
}
