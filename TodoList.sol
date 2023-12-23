// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TodoList {

    event CreateTask(uint taskid, string content, bool taskDone);
    event CompleteTask(uint taskid, bool taskDone);

    address public owner;
    uint public taskCount;

    struct Task {
        uint taskid;
        string content;
        bool taskDone;
    }

    mapping(uint => Task) public tasks;

    constructor() {
        owner = msg.sender;
    }

    function createTodoTask(string memory _content) external {
        taskCount++;

        tasks[taskCount] = Task(taskCount, _content, false);

        emit CreateTask(taskCount, _content, false);
    }

    function completeTask(uint _taskId) external {
        require(owner == msg.sender, "Task can only be completed by owner");

        require(_taskId <= taskCount && _taskId > 0, "Cannot access task ID");

        Task storage task = tasks[_taskId];
        require(!task.taskDone, "Task is already completed");

        task.taskDone = true;

        emit CompleteTask(_taskId, true);
    }
}